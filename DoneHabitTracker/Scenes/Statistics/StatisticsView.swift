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
        Text("Statistics Tab")
    }
}

#Preview {
    StatisticsView(appModel: ApplicationModel())
}
