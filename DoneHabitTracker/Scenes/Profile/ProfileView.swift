//
//  ProfileView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        
        VStack {
            Text("Profile")
                .padding(.leading)
                .font(.largeTitle)
            
            Text(Auth.auth().currentUser?.uid ?? "No UID")
                .padding(.leading)
                .font(.caption)
            
            Button("Logout") {
                try? Auth.auth().signOut()
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
