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
    
    var appModel: ApplicationModel
    
    var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }

    func setAppModel(_ appModel: ApplicationModel) {
        self.appModel = appModel
    }
    
    func login() async {
        do {
            appModel.isLoading = true
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            errorMessage = ""
            appModel.user = result.user
            appModel.isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            appModel.isLoading = false
            appModel.user = nil
        }
    }
    
    func setRoute(_ route: Route) {
        appModel.routes.append(route)
    }
}
