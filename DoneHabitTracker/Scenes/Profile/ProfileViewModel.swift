//
//  ProfileViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class ProfileViewModel : ObservableObject {
    
    var isLoading: Binding<Bool>
    @Published var user: FSUser?
    
    @Published var dayData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 23),
        .init(habitName: "Λεπτά Περπάτημα", value: 35),
    ]
    
    @Published var weekData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 33),
        .init(habitName: "Λεπτά Περπάτημα", value: 12),
    ]
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
        loadUserData()
    }
    
    func loadUserData() {
        if let uid = Auth.auth().currentUser?.uid {
            Task {
                isLoading.wrappedValue = true
                self.user = await fetchFirestoreUserInfo(userID: uid)
                isLoading.wrappedValue = false
            }
        }
    }
    
    func fetchFirestoreUserInfo(userID: String) async -> FSUser? {
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
}
