//
//  LoginView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: LoginViewModel(appModel: appModel))
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 32) {
            
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            
            VStack {
                
                AppTextField("login_email", text: $viewModel.email)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                AppTextField("login_password", text: $viewModel.password, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
            }
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("login_login")
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .foregroundColor(.white)
                            .background(viewModel.isFormValid ? Color.btnEnabled : Color.btnDisabled)
                            .cornerRadius(5)
                    }
                    .disabled(!viewModel.isFormValid)
                    
                    Spacer()
                }
                .font(.title)
                
                HStack {
                    Spacer()
                    Button("login_signup") {
                        viewModel.setRoute(.signupRoute);
                    }
                    .buttonStyle(.borderless)
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    LoginView(appModel: ApplicationModel())
}
