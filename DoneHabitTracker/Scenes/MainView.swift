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
                
                ProfileView(isLoading: $isLoading)
                
                    .tabItem {
                        Image("ti_profile")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Profile")
                    }
                    .tag(0)
                
                Text("Home Tab")
                    .tabItem {
                        Image("ti_home")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Home")
                    }
                    .tag(1)
                
                Text("Statistics Tab")
                    .tabItem {
                        Image("ti_statistics")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Statistics")
                    }
                    .tag(2)
                
                Text("Star Tab")
                    .tabItem {
                        Image("ti_star")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Star")
                    }
                    .tag(3)
                
                Text("Plus Tab")
                    .tabItem {
                        Image("ti_plus")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        Text("Plus")
                    }
                    .tag(4)
            }
        }
    }
}

#Preview {
    MainView(isLoading: .constant(false))
}
