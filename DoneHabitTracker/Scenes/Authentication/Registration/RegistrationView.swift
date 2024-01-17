//
//  RegistrationView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @Binding var isLoading: Bool
    @EnvironmentObject private var appModel: ApplicationModel
    
    @StateObject var viewModel: RegistrationViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: RegistrationViewModel(isLoading: isLoading))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            
            VStack {
                
                AppTextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                    .foregroundColor(viewModel.isEmailValid ? .primary : .red)
                
                AppTextField("Password", text: $viewModel.password, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                AppTextField("Repeat Password", text: $viewModel.repeatPassword, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                    .foregroundColor(viewModel.passwordsMatch ? .primary : .red)
                
                AppTextField("Profile Name", text: $viewModel.profile)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
            }
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                Task {
                    await viewModel.signUp()
                }
            }) {
                Text("SignUp")
                    .padding(16)
                    .foregroundColor(.white)
                    .background(viewModel.isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(5)
            }
            .disabled(!viewModel.isFormValid)
            
            Spacer()
        }
        .padding(16)
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear {
            viewModel.setAppModel(appModel)
        }
    }
}

#Preview {
    RegistrationView(isLoading: .constant(false))
}
