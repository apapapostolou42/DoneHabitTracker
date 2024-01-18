//
//  ProfileViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class ProfileViewModel : ObservableObject {
    var appModel: ApplicationModel
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userEmail: String = ""
    @Published var emailHint: String = ""
    
    @Published var userName: String = ""
    @Published var usernNameHint: String = ""
    
    @Published var user: FSUser?
    @Published var isEmailValid: Bool = true
    @Published var isUserNameValid: Bool = true
        
    @Published var canUpdateUserInfo: Bool = false
    
    @Published var showLogoutConfirmationAlert: Bool = false
    @Published var showChangeEmailConfirmationAlert: Bool = false
    @Published var showProfileDeletionConfirmationAlert: Bool = false

    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
        
        $user
            .receive(on: RunLoop.main)
            .compactMap { $0?.username }
            .assign(to: &$usernNameHint)
        
        $userEmail
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { [weak self] email in
                return email.isValidEmailAddress && email != self?.emailHint
            }
            .assign(to: &$isEmailValid)
        
        $userName
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .map { [weak self] userName in
                return !userName.trim().isEmpty && userName != self?.usernNameHint
            }
            .assign(to: &$isUserNameValid)
        
        
        Publishers.CombineLatest4($userEmail, $userName, $isEmailValid, $isUserNameValid)
        .map { userEmail, userName, isEmailValid, isUserNameValid in
            let atLeastOneFilled = isEmailValid || isUserNameValid
            
            let emailValidOrEmpty = isEmailValid || userEmail.trim().isEmpty
            let userNameValidOrEmpty = isUserNameValid || userName.trim().isEmpty
            
            return atLeastOneFilled && emailValidOrEmpty && userNameValidOrEmpty
        }
        .assign(to: &$canUpdateUserInfo)
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    func changeEmailTo(newEmail: String) {
        if let user = Auth.auth().currentUser {
            
            if let credential = appModel.credential {
                // changing emqil is sensitive and requires re authenticate the user
                user.reauthenticate(with: credential) { result, error  in
                    
                    if let error = error {
                        // An error happened.
                        print("ERROR 1 \(error.localizedDescription)")
                    } else {
                        // User re-authenticated.
                        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                            // email updated
                            print("ERROR 2 \(error?.localizedDescription ?? "")")
                            
                            if error == nil {
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requestPasswordReset() {
        if let email = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil {
                    
                }
            }
        }
    }
    
    func refreshUserData() {
        if let uid = Auth.auth().currentUser?.uid {
            Task {
                appModel.isLoading = true
                self.user = await fetchFirestoreUserInfo(userID: uid)
                self.usernNameHint = user?.username ?? ""
                self.emailHint = Auth.auth().currentUser?.email ?? ""
                appModel.isLoading = false
            }
        }
    }
    
    func updateProfile() {
        appModel.isLoading = true
        
        if let email = Auth.auth().currentUser?.email {
            if email != userEmail && userEmail.isValidEmailAddress {
                changeEmailTo(newEmail: userEmail)
            }
        }
        
        Task {
            await updateFirestoreUserInfo()
        }
        
        appModel.isLoading = false
    }
    
    func wipeUserAccount() async {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            
            do {
                try await db.collection("users").document(user.uid).delete()
                print("Document successfully removed!")
                
                try await user.delete()
                print("Account deleted")
                
                self.logout()
            } catch {
              print("Error removing document: \(error)")
            }
        }
    }
    
    private func fetchFirestoreUserInfo(userID: String) async -> FSUser? {
        let db = Firestore.firestore()

        let documentRef = db.collection("users").document(userID)

        do {
            let document = try await documentRef.getDocument()
            guard let data = document.data() else {
                print("Document does not exist")
                return nil
            }

            // Convert the Firestore document data to JSON
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            // Decode the JSON data to an FSUser object
            let fsUser = try JSONDecoder().decode(FSUser.self, from: jsonData)
            
            return fsUser
        } catch {
            print("Error fetching document: \(error)")
            return nil
        }
    }
    
    func updateFirestoreUserInfo() async {
        if !userName.isEmpty {
            if let uid = Auth.auth().currentUser?.uid {
                let db = Firestore.firestore()
                
                let documentRef = db.collection("users").document(uid)
                
                do {
                    try await documentRef.updateData([
                        "username": userName
                    ])
                    print("Document successfully updated")
                    
                    self.usernNameHint = userName
                    self.userName = ""
                } catch {
                    print("Error updating document: \(error)")
                }
            }
        }
    }
}
