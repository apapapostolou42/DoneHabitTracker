//
//  DoneHabitTrackerApp.swift
//  DoneHabitTracker
//
//  Created by Papapostolou, Athanasios on 12/12/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct DoneHabitTrackerApp: App {
    
    @State private var showSplash: Bool = true
    @State private var isLoading = false
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var appModel = ApplicationModel()
    
    var body: some Scene {
        WindowGroup {
            
            if !showSplash {
                NavigationStack(path: $appModel.routes) {
                    ZStack {
                        if appModel.user != nil {
                            MainView()
                        }
                        else {
                            LoginView(isLoading: $isLoading)
                        }
                    }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .signupRoute: RegistrationView(isLoading: $isLoading)
                        }
                    }
                }
                .environmentObject(appModel)
                .overlay {
                    isLoading ? Color.black.opacity(0.7).ignoresSafeArea() : nil
                }
                .overlay {
                    isLoading ? ProgressView().scaleEffect(1.5) : nil
                }
            } else {
                SplashView(showSplash: $showSplash)
            }
        }
    }
}
