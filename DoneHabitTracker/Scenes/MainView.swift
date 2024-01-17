//
//  MainView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    private var appModel: ApplicationModel
    @State private var selectedTab = 0
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab) {
                
                HomeView(appModel: appModel)
                    .tabItem {
                        Image("ti_home")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.btnEnabled : Color.btnDisabled)
                        Text("ti_home".localized)
                    }
                    .tag(0)
                
                HabitsView(appModel: appModel)
                    .tabItem {
                        Image("ti_star")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.btnEnabled : Color.btnDisabled)
                        Text("ti_habits")
                    }
                    .tag(1)
                
                NewHabitView(appModel: appModel)
                    .tabItem {
                        Image("ti_plus")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.btnEnabled : Color.btnDisabled)
                        Text("ti_new")
                    }
                    .tag(2)
                
                StatisticsView(appModel: appModel)
                    .tabItem {
                        Image("ti_statistics")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.btnEnabled : Color.btnDisabled)
                        Text("ti_statistics")
                    }
                    .tag(3)
                
                ProfileView(appModel: appModel)
                    .tabItem {
                        Image("ti_profile")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.btnEnabled : Color.btnDisabled)
                        Text("ti_profile")
                    }
                    .tag(4)
            }
        }
    }
}

#Preview {
    MainView(appModel: ApplicationModel())
}
