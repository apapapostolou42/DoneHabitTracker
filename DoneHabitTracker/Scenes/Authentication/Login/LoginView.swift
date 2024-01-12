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
            
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Login")
                .padding(.leading)
                .font(.title)
                
            
            Form {
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Spacer()
                        Button("Login") {
                            Task {
                                await viewModel.login()
                            }
                        }
                        .disabled(!viewModel.isFormValid)
                        .buttonStyle(.borderless)
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
            }
        }
        .padding(.top, 16)
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear {
            viewModel.setAppModel(appModel)
        }
    }
}

#Preview {
    LoginView(isLoading: .constant(false))
}
