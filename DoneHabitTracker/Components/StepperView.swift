//
//  StepperView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 15/1/24.
//

import SwiftUI

struct StepperView: View {
    @Binding var value: Int
    var increment: Int
    var enabled: Bool = true

    init(value: Binding<Int>, increment: Int = 1) {
        self._value = value
        self.increment = increment
    }

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                if value > 0 { value -= increment }
            }) {
                Image(systemName: "minus")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .background(value > 0 && enabled ? Color.btnEnabled : Color.btnDisabled)
                    .cornerRadius(5)
            }
            .disabled(value <= 0 || !enabled)

            Text("\(value)")
                .frame(minWidth: 40, minHeight: 40)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .cornerRadius(5)

            Button(action: {
                value += increment
            }) {
                Image(systemName: "plus")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .background(enabled ? Color.btnEnabled : Color.btnDisabled)
                    .cornerRadius(5)
            }
            .disabled(!enabled)
        }
    }
}

#Preview {
    VStack {
        HStack(spacing: 16) {
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 0)
            StepperView(value: .constant(0))
        }
        
        HStack(spacing: 16) {
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 22)
            StepperView(value: .constant(0))
        }
        
        HStack(spacing: 16) {
            ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 32)
            StepperView(value: .constant(0))
        }
    }
    .padding(16)
}
