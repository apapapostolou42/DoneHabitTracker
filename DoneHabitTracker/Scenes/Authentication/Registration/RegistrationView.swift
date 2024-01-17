//
//  RegistrationView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI

struct RegistrationView: View {

    @StateObject var viewModel: RegistrationViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: RegistrationViewModel(appModel: appModel))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            
            VStack {
                
                AppTextField("signup_email", text: $viewModel.email)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                    .foregroundColor(viewModel.isEmailValid ? .primary : .red)
                
                AppTextField("signup_password", text: $viewModel.password, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                AppTextField("signup_password_repeat", text: $viewModel.repeatPassword, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                    .foregroundColor(viewModel.passwordsMatch ? .primary : .red)
                
                AppTextField("signup_profilename", text: $viewModel.profile)
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
                Text("signup_signup")
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .foregroundColor(.white)
                    .background(viewModel.isFormValid ? Color.btnEnabled : Color.btnDisabled)
                    .cornerRadius(5)
            }
            .disabled(!viewModel.isFormValid)
            
            Spacer()
        }
        .padding(16)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    RegistrationView(appModel: ApplicationModel())
}
