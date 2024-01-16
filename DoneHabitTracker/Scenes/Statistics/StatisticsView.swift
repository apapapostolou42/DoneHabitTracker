//
//  StatisticsView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct StatisticsView: View {
    @Binding var isLoading: Bool
    @StateObject var viewModel: StatisticsViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: StatisticsViewModel(isLoading: isLoading))
    }
    
    var body: some View {
        Text("Statistics Tab")
    }
}

#Preview {
    StatisticsView(isLoading: .constant(false))
}
