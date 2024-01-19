//
//  DemoViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

@MainActor
class DemoViewModel : ObservableObject {
    var appModel: ApplicationModel
    
    @Published var dayData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 23),
        .init(habitName: "Λεπτά Περπάτημα", value: 35),
    ]
    
    @Published var weekData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 33),
        .init(habitName: "Λεπτά Περπάτημα", value: 12),
    ]
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }
}
