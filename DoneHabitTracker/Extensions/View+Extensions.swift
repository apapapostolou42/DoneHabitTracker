//
//  View+Extensions.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 17/1/24.
//

import SwiftUI

extension View {
    func applyColorSchemeIfNeeded(_ themeType: String) -> some View {
        switch themeType {
            case ThemeType.light.rawValue:
                return AnyView(self.environment(\.colorScheme, .light))
            case ThemeType.dark.rawValue:
                return AnyView(self.environment(\.colorScheme, .dark))
            default:
                return AnyView(self)
        }
    }
}
