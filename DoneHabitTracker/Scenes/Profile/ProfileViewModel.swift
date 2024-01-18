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
    
    @Published var userEmail: String = ""
    @Published var userName: String = ""
    @Published var user: FSUser?
    @Published var isEmailValid: Bool = true
    
    @Published var showLogoutConfirmationAlert: Bool = false
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
        
        $user
            .receive(on: RunLoop.main)
            .compactMap { $0?.username }
            .assign(to: &$userName)
        
        $userEmail
            .receive(on: RunLoop.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .compactMap { $0.isValidEmailAddress }
            .assign(to: &$isEmailValid)
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    func changeEmailTo(newEmail: String) {
        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
            // ...
        }
    }
    
    func requestPasswordReset() {
        if let email = Auth.auth().currentUser?.email {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                // ...
            }
        }
    }
    
    func refreshUserData() {
        if let uid = Auth.auth().currentUser?.uid {
            Task {
                appModel.isLoading = true
                self.user = await fetchFirestoreUserInfo(userID: uid)
                self.userEmail = Auth.auth().currentUser?.email ?? ""
                
                appModel.isLoading = false
            }
        }
    }
    
    func updateProfile() {
        // update the email
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
                } catch {
                    print("Error updating document: \(error)")
                }
            }
        }
    }
}
