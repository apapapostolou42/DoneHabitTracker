//
//  String+Extensions.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import Foundation


extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
