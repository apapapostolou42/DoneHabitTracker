//
//  ProfileImage.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3.0)
                .background(Color.clear)
                .foregroundColor(.primary)
                .frame(width: 44, height: 44)
            
            
            Image("ti_profile")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.primary)
                .frame(width: 32, height: 32)
        }
        .tint(.primary)
    }
}

#Preview {
    ProfileImage()
}
