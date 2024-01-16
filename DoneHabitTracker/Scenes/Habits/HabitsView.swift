//
//  HabitsView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct HabitsView: View {
    
    @Binding var isLoading: Bool
    @StateObject var viewModel: HabitsViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: HabitsViewModel(isLoading: isLoading))
    }
    
    var body: some View {
        Text("Habits Tab")
    }
}

#Preview {
    HabitsView(isLoading: .constant(false))
}
