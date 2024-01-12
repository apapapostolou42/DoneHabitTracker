//
//  ActiveHabit.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import Foundation

struct ActiveHabit : Codable, Identifiable {
    var frequency : String = ""
    var id: String = ""
    var progression: String = ""
    var target: String = ""
    var unit: String = ""
}
