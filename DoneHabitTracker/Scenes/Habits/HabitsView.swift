//
//  HabitsView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct HabitsView: View {
    
    @StateObject var viewModel: HabitsViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: HabitsViewModel(appModel: appModel))
    }
    
    var body: some View {
        Text("Habits Tab")
    }
}

#Preview {
    HabitsView(appModel: ApplicationModel())
}
