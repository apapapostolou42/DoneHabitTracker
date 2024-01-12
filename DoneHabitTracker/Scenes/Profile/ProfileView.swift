//
//  ProfileView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @Binding var isLoading: Bool
    @StateObject var viewModel: ProfileViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(isLoading: isLoading))
    }
    
    var body: some View {
        
        VStack(spacing: 16) {
            Text("Profile")
                .padding(.leading)
                .font(.largeTitle)
            
            Text(Auth.auth().currentUser?.uid ?? "No UID")
                .padding(.leading)
                .font(.caption)
            
            Text("NAME: \(viewModel.user?.username ?? "Undefined")")
                .padding(.leading)
            
            
            Button("Logout") {
                try? Auth.auth().signOut()
                
            }
        }
    }
}

#Preview {
    ProfileView(isLoading: .constant(false))
}
