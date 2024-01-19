//
//  HomeViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

@MainActor
class HomeViewModel : ObservableObject {
    var appModel: ApplicationModel
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }
}
