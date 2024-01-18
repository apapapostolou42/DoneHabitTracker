//
//  AlertItem.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 18/1/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var primaryButtonText: String
    var secondaryButtonText: String?
    var primaryAction: (() -> Void)?
    var secondaryAction: (() -> Void)?

    // Initializer for alert with both buttons
    init(title: String, message: String, primaryButtonText: String, primaryAction: (() -> Void)? = nil, secondaryButtonText: String? = nil, secondaryAction: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.primaryButtonText = primaryButtonText
        self.primaryAction = primaryAction
        self.secondaryButtonText = secondaryButtonText
        self.secondaryAction = secondaryAction
    }

    // Initializer for alert with only primary button
    init(title: String, message: String, primaryButtonText: String, primaryAction: (() -> Void)? = nil) {
        self.init(title: title, message: message, primaryButtonText: primaryButtonText, primaryAction: primaryAction, secondaryButtonText: nil, secondaryAction: nil)
    }
}
