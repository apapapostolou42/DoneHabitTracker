//
//  AppHeader.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct AppHeader: View {
    
    @EnvironmentObject private var appModel: ApplicationModel
    private let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title.localizedString(locale: Locale(identifier: appModel.selectedLanguage)))
            .font(.system(size: 44).bold())
            .foregroundColor(.primary)
            .underline()
    }
}

#Preview {
    AppHeader("profile_profile")
}
