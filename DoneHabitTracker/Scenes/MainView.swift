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
    @State private var selectedTab = 0
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab) {
                
                Text("Home Tab")
                    .tabItem {
                        Image("ti_home")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Home")
                    }
                    .tag(0)
                
                Text("Habits Tab")
                    .tabItem {
                        Image("ti_star")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Habits")
                    }
                    .tag(1)
                
                Text("New Tab")
                    .tabItem {
                        Image("ti_plus")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("New")
                    }
                    .tag(2)
                
                Text("Statistics Tab")
                    .tabItem {
                        Image("ti_statistics")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Statistics")
                    }
                    .tag(3)
                
                ProfileView(isLoading: $isLoading)
                    .tabItem {
                        Image("ti_profile")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Profile")
                    }
                    .tag(4)
            }
        }
    }
}

#Preview {
    MainView(isLoading: .constant(false))
}
