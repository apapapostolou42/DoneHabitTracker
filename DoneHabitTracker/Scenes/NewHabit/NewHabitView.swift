//
//  NewHabitView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct NewHabitView: View {
    @StateObject var viewModel: NewHabitViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: NewHabitViewModel(appModel: appModel))
    }
    
    var body: some View {
        Text("New Habit Tab")
    }
}

#Preview {
    NewHabitView(appModel: ApplicationModel())
}
