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
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Registration")
                .padding(.leading)
                .font(.title)
            
            Form {
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                TextField("Profile Name", text: $viewModel.profile)
                    .textInputAutocapitalization(.never) // Disables auto-capitalization
                    .disableAutocorrection(true)         // Disables auto-correction
                
                HStack {
                    
                    Spacer()
                    
                    Button("SignUp") {
                        Task {
                            await viewModel.signUp()
                        }
                    }
                    .disabled(!viewModel.isFormValid)
                    .buttonStyle(.borderless)
                    
                    Spacer()
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
    RegistrationView(isLoading: .constant(false))
}
