//
//  ApplicationModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import Foundation
import FirebaseAuth
import Network

enum Route: Hashable {
    case signupRoute
}

@MainActor
class ApplicationModel: ObservableObject {
    
    // Checking Network Availability
    @Published var isNetworkDown: Bool = false
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    
    // Signed User
    @Published var user: User? = nil
    
    // Navigation
    @Published var routes: [Route] = []
 
    func resetToTopView(_ route: Route) {
        routes = [route]
    }
    
    init() {
        initializeNetowrkMonitor()
        
        self.user = Auth.auth().currentUser
        setupAuthenticationListener()
    }
    
    private func initializeNetowrkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isNetworkDown = path.status != .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    private func setupAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if let user = user {
                // User is signed in
                self.user = user
            } else {
                // No user is signed in
                self.user = nil
            }
        }
    }
}
