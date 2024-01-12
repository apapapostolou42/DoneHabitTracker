//
//  FSUser.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import Foundation

struct FSUser : Codable, Identifiable {
    var activeHabits: [ActiveHabit]
    var avatar: String
    var customHabits: [CustomHabit]
    var email: String
    var id: String
    var username: String
}
