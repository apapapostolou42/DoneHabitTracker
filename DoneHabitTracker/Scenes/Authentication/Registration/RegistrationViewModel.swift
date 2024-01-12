//
//  RegistrationViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var profile: String = ""
    @Published var errorMessage: String = ""
    
    @Published var passwordsMatch: Bool = false
    @Published var isEmailValid: Bool = false
    
    var appModel: ApplicationModel?
    var isLoading: Binding<Bool>
    
    var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && isEmailValid &&
        !password.isEmptyOrWhiteSpace &&
        password.count >= 6 &&
        passwordsMatch &&
        !profile.isEmptyOrWhiteSpace
    }
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
        
        Publishers.CombineLatest(
            $password.debounce(for: 0.1, scheduler: RunLoop.main),
            $repeatPassword.debounce(for: 0.1, scheduler: RunLoop.main)
        )
        .map { password, repeatPassword in
            return password == repeatPassword && !password.isEmpty && password.count >= 6
        }
        .assign(to: &$passwordsMatch)
        
        $email
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { [weak self] email in
                return self?.email.isValidEmailAddress ?? false
            }
            .assign(to: &$isEmailValid)
    }
    
    func setAppModel(_ appModel: ApplicationModel) {
        self.appModel = appModel
    }
    
    func signUp() async {
        guard let appModel = appModel else { return }
        
        do {
            isLoading.wrappedValue = true
            let result = try await Auth.auth().createUser(withEmail: email.trim(), password: password.trim())
            errorMessage = ""
            appModel.user = result.user
            await updateFirestoreUserInfo(user: result.user)
            isLoading.wrappedValue = false
            appModel.routes.removeLast()
        }
        catch {
            errorMessage = error.localizedDescription
            isLoading.wrappedValue = false
            appModel.user = nil
        }
    }
    
    func updateFirestoreUserInfo(user: User) async {
        let db = Firestore.firestore()
        
        let fsUser = FSUser(activeHabits: [], avatar: "", customHabits: [], email: user.email ?? "", id: user.uid, username: profile.trim())
        
        // Convert your FSUser to a dictionary
        do {
            let data = try JSONEncoder().encode(fsUser)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("Error: Could not convert user to dictionary")
                return
            }

            let documentRef = db.collection("users").document(user.uid)
            
            do {
                try await documentRef.setData(dictionary)
                print("Document successfully written with ID: \(user.uid)")
            } catch {
                print("Error writing document: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
