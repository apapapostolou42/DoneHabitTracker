//
//  HomeView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    @State var currentStep1: Int = 0
    @State var currentStep2: Int = 15
    @State var currentStep3: Int = 0
    @State var currentStep4: Int = 3
    @State var currentStep5: Int = 4
    @State var currentStep6: Int = 0
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(appModel: appModel))
    }
    
    private let tabItems = [
        AppTabItem(title: "Today", count: 3),
        AppTabItem(title: "Week", count: 1),
        AppTabItem(title: "Month", count: 0)
    ]
    @State private var selectedTabIndex = 1
    
    @State private var isChecked: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(spacing: 32) {
                    ProfileImage()
                    Text("Hello <Username>")
                    Spacer()
                }
                
                AppTabView(tabItems: tabItems, selectedTabIndex: $selectedTabIndex)
                
                
                HStack(spacing: 0) {
                    Text("This week you completed")
                    Spacer()
                    ChartsDougnutProgress(percentage: 35)
                        .frame(width: 100)
                        .scaleEffect(0.8)
                }
                
                Group {
                    AppHeader("Pending Habits")
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // foreach
                        
                        EditableHabit(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: $currentStep1)
                        
                        EditableHabit(text: "Λεπτά Περπάτημα", totalSteps: 20, currentStep: $currentStep2)
                        
                        EditableHabit(text: "Μαγείρεμα", totalSteps: 1, currentStep: $currentStep3)
                        
                        EditableHabit(text: "Μικρά Γεύματα", totalSteps: 5, currentStep: $currentStep4)
                        
                        EditableHabit(text: "Μικρά Γεύματα", totalSteps: 5, currentStep: $currentStep5)
                        
                        EditableHabit(text: "Γυμναστήριο", totalSteps: 1, currentStep: $currentStep6)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    AppHeader("Completed")
                    
                    
                    VStack(spacing: 8) {
                        // foreach
                        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 1, currentStep: 1)
                        
                        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 1, currentStep: 2)
                        
                        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 1, currentStep: 1)
                    }
                }
               
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView(appModel: ApplicationModel())
}
