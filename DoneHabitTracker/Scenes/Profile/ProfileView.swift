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
            
            HStack {
                Text("Profile")
                    .padding(.leading)
                    .font(.largeTitle)
                
                Spacer()
                
                CircularProgressBar(percentage: 79)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 0)
            
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 10)
            
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 32)
            
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 40)
                        
            
            Spacer()
            
            
            Text(Auth.auth().currentUser?.uid ?? "No UID")
                .padding(.leading)
                .font(.caption)
            
            Text("NAME: \(viewModel.user?.username ?? "Undefined")")
                .padding(.leading)
            
            
            Button("Logout") {
                try? Auth.auth().signOut()
                
            }
        }
        .padding(32)
    }
}

#Preview {
    ProfileView(isLoading: .constant(false))
}
