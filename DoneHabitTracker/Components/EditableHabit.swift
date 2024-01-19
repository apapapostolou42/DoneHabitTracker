//
//  EditableHabit.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct EditableHabit: View {
    
    let text: String
    let totalSteps: Int
    @Binding var value: Int
    
    
    init(text: String, totalSteps: Int, currentStep: Binding<Int>) {
        self.text = text
        self.totalSteps = totalSteps
        self._value = currentStep
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            
            if totalSteps > 1 {
                HStack(spacing: 16) {
                    ProgressBar(text: text, totalSteps: totalSteps, currentStep: value)
                    StepperView(value: $value)
                        .frame(width: 100)
                }
            }
            else {
                
                HStack(spacing: 16) {
                    ProgressBar(text: text, totalSteps: totalSteps, currentStep: value)
                    
                    HStack {
                        AppCheckbox(value: $value)
                    }
                    .frame(width: 100)
                }
            }
        }
    }
}

#Preview {
    VStack {
        EditableHabit(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: .constant(0))
        
        EditableHabit(text: "Λεπτά Περπάτημα", totalSteps: 12, currentStep: .constant(5))
        
        EditableHabit(text: "Μαγείρεμα", totalSteps: 1, currentStep: .constant(0))
        
        EditableHabit(text: "Μικρά Γεύματα", totalSteps: 5, currentStep: .constant(3))
        
        EditableHabit(text: "Μικρά Γεύματα", totalSteps: 5, currentStep: .constant(7))
        
        EditableHabit(text: "Γυμναστήριο", totalSteps: 1, currentStep: .constant(1))
    }
    .padding(16)
}
