//
//  HomeViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class HomeViewModel : ObservableObject {
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
