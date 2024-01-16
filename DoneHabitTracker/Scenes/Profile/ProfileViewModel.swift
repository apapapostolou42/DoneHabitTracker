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
    
    var isLoading: Binding<Bool>
    @Published var user: FSUser?
    
    init(isLoading: Binding<Bool>) {
        self.isLoading = isLoading
    }
}
