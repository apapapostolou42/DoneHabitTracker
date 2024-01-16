//
//  NewHabitView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct NewHabitView: View {
    @Binding var isLoading: Bool
    @StateObject var viewModel: NewHabitViewModel
    
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
        self._viewModel = StateObject(wrappedValue: NewHabitViewModel(isLoading: isLoading))
    }
    
    var body: some View {
        Text("New Habit Tab")
    }
}

#Preview {
    NewHabitView(isLoading: .constant(false))
}
