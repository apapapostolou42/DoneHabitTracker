//
//  StatisticsViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

@MainActor
class StatisticsViewModel : ObservableObject {
    var appModel: ApplicationModel
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }
}
