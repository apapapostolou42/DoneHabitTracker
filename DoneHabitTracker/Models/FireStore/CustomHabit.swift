//
//  CustomHabit.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import Foundation

struct CustomHabit: Codable, Identifiable {
    var category : String = ""
    var id: String = ""
    var iconName: String = ""
    var name: String = ""
}
