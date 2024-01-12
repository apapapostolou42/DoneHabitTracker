//
//  RegistrationViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var profile: String = ""
    @Published var errorMessage: String = ""
    
    var appModel: ApplicationModel?
    var isLoading: Binding<Bool>
    
    var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !profile.isEmptyOrWhiteSpace
    }
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }
    
    func setAppModel(_ appModel: ApplicationModel) {
        self.appModel = appModel
    }
    
    func signUp() async {
        guard let appModel = appModel else { return }
        
        do {
            isLoading.wrappedValue = true
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
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
        
        let fsUser = FSUser(activeHabits: [], avatar: "", customHabits: [], email: user.email ?? "", id: user.uid, username: user.email ?? "")
        
        // Convert your FSUser to a dictionary
        do {
            let data = try JSONEncoder().encode(fsUser)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("Error: Could not convert user to dictionary")
                return
            }
            
            // Add a new document with a generated ID in collection "users"
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: dictionary) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
