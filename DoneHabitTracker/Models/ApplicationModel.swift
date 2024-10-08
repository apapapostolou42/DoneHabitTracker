//
//  ApplicationModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import Foundation
import FirebaseAuth
import Network
import Combine
import SwiftUI

enum Route: Hashable {
    case signupRoute
}

enum ThemeType: String {
    case system = "theme_str_system"
    case dark = "theme_str_dark"
    case light = "theme_str_light"
}

enum AppLanguage: String {
    case en = "en"
    case el = "el"
}

enum UserDefaultsKey: String {
    case theme = "THEME"
    case lang = "LANG"
}

@MainActor
class ApplicationModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
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
    
    var credential: AuthCredential? = nil
    
    // application themes
    var themes: [ThemeType] = [.system, .light, .dark]
    @Published var selectedTheme: String
    
    
    // application localization
    var languages: [AppLanguage] = [.el, .en]
    @Published var selectedLanguage: String
    
    
    @Published var isLoading = false;
    
    init() {
        // Set Theme
        self.selectedTheme = UserDefaults.standard.string(forKey: UserDefaultsKey.theme.rawValue) ?? themes[0].rawValue
        self.selectedLanguage =  UserDefaults.standard.string(forKey: UserDefaultsKey.lang.rawValue) ?? languages[0].rawValue
        
        $selectedTheme
            .sink { newTheme in
                UserDefaults.standard.set(newTheme, forKey: UserDefaultsKey.theme.rawValue)
            }
            .store(in: &cancellables)
        
        $selectedLanguage
            .sink { newLanguage in
                UserDefaults.standard.set(newLanguage, forKey: UserDefaultsKey.lang.rawValue)
            }
            .store(in: &cancellables)
        
        // Monitor Network
        initializeNetowrkMonitor()
        self.user = Auth.auth().currentUser
        
        // Track User status
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
