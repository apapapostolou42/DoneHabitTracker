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
    
    @Published var showDeletionConfirmationAlert: Bool = false
    
    let pills = [
        PillTag(text: "All"),
        PillTag(text: "Fitness"),
        PillTag(text: "Daily"),
        PillTag(text: "Custom")
    ];
    @Published var selectdTag: PillTag?
    
    @Published var dayData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 100),
        .init(habitName: "Λεπτά Περπάτημα", value: 75),
        .init(habitName: "Udemy", value: 40),
        .init(habitName: "Μαγείρεμα", value: 35),
        .init(habitName: "Μικρά Γεύματα", value: 0),
        .init(habitName: "Γυμναστήριο", value: 22),
    ]
    
    @Published var weekData: [ChartsBar.Item] = [
        .init(habitName: "Ποτήρια Νερό", value: 80),
        .init(habitName: "Λεπτά Περπάτημα", value: 49),
        .init(habitName: "Udemy", value: 60),
        .init(habitName: "Μαγείρεμα", value: 65),
        .init(habitName: "Μικρά Γεύματα", value: 20),
        .init(habitName: "Γυμναστήριο", value: 40),
    ]
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
        selectdTag = pills[0]
    }
}
