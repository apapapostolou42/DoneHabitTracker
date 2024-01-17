//
//  ProfileViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class ProfileViewModel : ObservableObject {
    var appModel: ApplicationModel
    
    init(appModel: ApplicationModel) {
        self.appModel = appModel
    }
}
