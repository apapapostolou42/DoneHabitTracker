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
    
    @State var currentGlasses: Int = 0
    @State var selectedPill: PillTag? = nil
    
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(appModel: appModel))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 16) {
                
                HStack {
                    // First way to use doughnut throuth Swift Charts
                    ChartsDougnutProgress(percentage: 32)
                    
                    Spacer()
                    
                    // Second way to use doughnut through custom Control
                    CircularProgressBar(percentage: 79)
                        .frame(width: 120, height: 120)
                }
                
                Spacer()
                
                PillTagsView(
                    pillTags: [
                        PillTag(text: "All"),
                        PillTag(text: "Fitness"),
                        PillTag(text: "Daily"),
                        PillTag(text: "Custom"),
                        PillTag(text: "Item 1"),
                        PillTag(text: "Item 2")
                    ],
                    selectedTag: $selectedPill
                )
                
                ChartsBar(dayData: viewModel.dayData, weekData:  viewModel.weekData)
                
                Spacer()
                
                HStack(spacing: 8) {
                    ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: currentGlasses)
                    StepperView(value: $currentGlasses)
                }
                
                ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 10)
                
                ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 32)
                
                ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 40)
                
                
                Spacer()
                
                
                Text(Auth.auth().currentUser?.uid ?? "No UID")
                    .padding(.leading)
                    .font(.caption)
                
                Text("NAME: \(viewModel.user?.username ?? "Undefined")")
                    .padding(.leading)
                
                
                Button("profile_btn_logout".localized) {
                    try? Auth.auth().signOut()
                    
                }
            }
        }
        .padding(32)
    }
}

#Preview {
    HomeView(appModel: ApplicationModel())
}
