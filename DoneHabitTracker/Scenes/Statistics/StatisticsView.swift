//
//  StatisticsView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject var viewModel: StatisticsViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: StatisticsViewModel(appModel: appModel))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                AppHeader("Statistics")
                Spacer()
            }
            
            PillTagsView(
                pillTags: viewModel.pills,
                selectedTag: $viewModel.selectdTag)
            
            
            ScrollView(showsIndicators: false) {
                ChartsPie(data: [
                    ChartsPie.ShapeModel(type: "Circle",    count: 12),
                    ChartsPie.ShapeModel(type: "Square",    count: 10),
                    ChartsPie.ShapeModel(type: "Triangle",  count: 21),
                    ChartsPie.ShapeModel(type: "Rectangle", count: 15),
                    ChartsPie.ShapeModel(type: "Hexagon",   count: 8)
                ])
                .frame(width: 250, height: 250)
                .padding(.bottom, 32)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.7))
                    .padding(.bottom, 32)
                
                ChartsBar(dayData: viewModel.dayData, weekData:  viewModel.weekData)
                    .padding(.bottom, 32)
                
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.showDeletionConfirmationAlert = true
                    }) {
                        Text("Reset Statistics")
                            .padding(8)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(5)
                    }
                    .alert(isPresented: $viewModel.showDeletionConfirmationAlert) {
                        Alert(
                            title: Text("Statistics Reset"),
                            message: Text("Are you sure you want to delete all statistics.  This action is irreversable."),
                            primaryButton: .default(Text("Yes")) {
                                Task {
                                    
                                }
                            },
                            secondaryButton: .default(Text("No")) {}
                        )
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    StatisticsView(appModel: ApplicationModel())
}
