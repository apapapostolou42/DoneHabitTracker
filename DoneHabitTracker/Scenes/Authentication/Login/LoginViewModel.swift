//
//  LoginViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    var appModel: ApplicationModel?
    var isLoading: Binding<Bool>
    
    var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }

    func setAppModel(_ appModel: ApplicationModel) {
        self.appModel = appModel
    }
    
    func login() async {
        guard let appModel = appModel else { return }
        
        do {
            isLoading.wrappedValue = true
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            errorMessage = ""
            appModel.user = result.user
            isLoading.wrappedValue = false
            appModel.resetToTopView(.mainRoute)
        } catch {
            errorMessage = error.localizedDescription
            isLoading.wrappedValue = false
            appModel.user = nil
        }
    }
}
