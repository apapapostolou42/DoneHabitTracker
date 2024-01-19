//
//  AppHeader.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct AppHeader: View {
    
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text("\(title.localized)")
            .font(.system(size: 44).bold())
            .foregroundColor(.primary)
            .underline()
    }
}

#Preview {
    AppHeader("profile_profile")
}
