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
    @State private var selectedTabIndex = 1
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(appModel: appModel))
    }
    
    private let tabItems = [
        AppTabItem(title: "Today", count: 3),
        AppTabItem(title: "Week", count: 1),
        AppTabItem(title: "Month", count: 0)
    ]
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 16) {
                
                AppTabView(tabItems: tabItems, selectedTabIndex: $selectedTabIndex)
                
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
                
                ChartsPie(data: [
                    ChartsPie.ShapeModel(type: "Circle",    count: 12),
                    ChartsPie.ShapeModel(type: "Square",    count: 10),
                    ChartsPie.ShapeModel(type: "Triangle",  count: 21),
                    ChartsPie.ShapeModel(type: "Rectangle", count: 15),
                    ChartsPie.ShapeModel(type: "Hexagon",   count: 8)
                ])
                .frame(width: 250, height: 250)
                
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
            }
        }
        .padding(16)
    }
}

#Preview {
    HomeView(appModel: ApplicationModel())
}
