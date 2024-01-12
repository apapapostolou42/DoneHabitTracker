//
//  MainView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    @Binding var isLoading: Bool
    
    var body: some View {
        
        ZStack {
            TabView {
                ProfileView(isLoading: $isLoading)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                Text("Search Tab")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                Text("Profile Tab")
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
        }
    }
}

#Preview {
    MainView(isLoading: .constant(false))
}
