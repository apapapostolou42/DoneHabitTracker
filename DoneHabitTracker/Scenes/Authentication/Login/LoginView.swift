//
//  LoginView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isLoading: Bool
    @EnvironmentObject private var appModel: ApplicationModel
    
    @StateObject var viewModel: LoginViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: LoginViewModel(isLoading: isLoading))
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
                
                AppTextField("Password", text: $viewModel.password, secured: true)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
            }
            
            
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("Login")
                            .padding(16)
                            .foregroundColor(.white)
                            .background(viewModel.isFormValid ? Color.blue : Color.gray)
                            .cornerRadius(5)
                    }
                    .disabled(!viewModel.isFormValid)
                    
                    Spacer()
                }
                .font(.title)
                
                HStack {
                    Spacer()
                    Button("SignUp") {
                        appModel.routes.append(.signupRoute)
                    }
                    .buttonStyle(.borderless)
                    Spacer()
                }
            }
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            
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
    LoginView(isLoading: .constant(false))
}
