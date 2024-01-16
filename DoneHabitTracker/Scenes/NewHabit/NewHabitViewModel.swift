//
//  NewHabitViewModel.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

@MainActor
class NewHabitViewModel : ObservableObject {
    var isLoading: Binding<Bool>
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }
}
