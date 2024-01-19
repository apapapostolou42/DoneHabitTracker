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
                        .alert(isPresented: $appModel.isNetworkDown) {
                            Alert(
                                title: Text("network_error_alert_title"),
                                message: Text("network_error_alert_message"),
                                dismissButton: .default(Text("OK")) {}
                            )
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

        }
    }
}
