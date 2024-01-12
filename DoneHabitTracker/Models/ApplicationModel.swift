//
//  ApplicationModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import Foundation
import FirebaseAuth

enum Route: Hashable {
    case mainRoute
    case loginRoute
    case signupRoute
}

@MainActor
class ApplicationModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var routes: [Route] = []
 
    func resetToTopView(_ route: Route) {
        routes = [route]
    }
    
    init() {
        self.user = Auth.auth().currentUser
        setupAuthenticationListener()
    }
    
    private func setupAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if let user = user {
                // User is signed in
                self.user = user
                self.resetToTopView(.mainRoute)
            } else {
                // No user is signed in
                self.user = nil
                self.resetToTopView(.loginRoute)
            }
        }
    }
}
