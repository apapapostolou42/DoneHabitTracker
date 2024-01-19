//
//  AppCheckbox.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct AppCheckbox: View {
    @Binding var value: Int

    var isChecked: Bool {
        value == 1
    }

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .foregroundColor(isChecked ? .blue : .gray)
            .onTapGesture {
                withAnimation {
                    value = isChecked ? 0 : 1
                }
            }
            .frame(width: 32, height: 32)
    }
}

#Preview {

    VStack(spacing: 8) {
        AppCheckbox(value: .constant(1))
        AppCheckbox(value: .constant(0))
    }
}
