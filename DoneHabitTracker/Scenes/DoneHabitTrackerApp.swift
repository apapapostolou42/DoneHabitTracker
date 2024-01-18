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
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var appModel = ApplicationModel()
    
    var body: some Scene {
        WindowGroup {
            
            Group {
                if !showSplash {
                    NavigationStack(path: $appModel.routes) {
                        ZStack {
                            if appModel.user != nil {
                                MainView(appModel: appModel)
                            }
                            else {
                                LoginView(appModel: appModel);
                            }
                        }
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                                case .signupRoute: RegistrationView(appModel: appModel)
                            }
                        }
                    }
                    
                } else {
                    SplashView(showSplash: $showSplash)
                }
            }
            .environmentObject(appModel)
            .overlay {
                appModel.isLoading ? Color.black.opacity(0.6).ignoresSafeArea() : nil
            }
            .overlay {
                appModel.isLoading ?
                    ProgressView().scaleEffect(2.0)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                : nil
                
            }
            .applyColorSchemeIfNeeded(appModel.selectedTheme)
            .environment(\.locale, .init(identifier: appModel.selectedLanguage))
            
            .alert(item: $appModel.currentAlert) { alertItem in
                // Check if secondaryButton is defined
                if alertItem.secondaryButtonText != nil {
                    return Alert(title: Text(alertItem.title),
                                 message: Text(alertItem.message),
                                 primaryButton: .default(Text(alertItem.primaryButtonText), action: alertItem.primaryAction),
                                 secondaryButton: .cancel(Text(alertItem.secondaryButtonText!), action: alertItem.secondaryAction))
                } else {
                    return Alert(title: Text(alertItem.title),
                                 message: Text(alertItem.message),
                                 dismissButton: .default(Text(alertItem.primaryButtonText), action: alertItem.primaryAction))
                }
            }
        }
    }
}
