//
//  ProgressBar.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 15/1/24.
//

import SwiftUI

struct ProgressBar: View {
    var text: String
    var totalSteps: Int
    var currentStep: Int
    var backgroundColor: Color = .white
    var borderColor: Color = .gray
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 5
    var height: CGFloat = 40
    
    init(text: String, totalSteps: Int, currentStep: Int) {
        self.text = text
        self.totalSteps = totalSteps
        self.currentStep = currentStep
    }
    
    init(text: String, totalSteps: Int, currentStep: Int, backgroundColor: Color = .white, borderColor: Color = .gray, borderWidth: CGFloat = 2, cornerRadius: CGFloat = 5, height: CGFloat = 40) {
        self.text = text
        self.totalSteps = totalSteps
        self.currentStep = currentStep
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.height = height
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Background Rect
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(currentStep == 0 ? .appRed : backgroundColor)
                .frame(height: height)

            // Fill Rect
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(getFillColor())
                    .frame(width: calculateFillWidth(for: geometry.size.width), height: height)
                    .animation(.linear, value: currentStep)
            }
            .frame(height: height)

            // Text
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .padding(.leading, 16)
                .frame(height: height)
        }
        .frame(height: height)
        // Border
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }

    private func getFillColor() -> Color {
        if currentStep <= 0 { return .appRed } else
        if currentStep < totalSteps { return .appYellow } else
        if currentStep == totalSteps { return .appGreenLight }
        return .appGreenDeep
    }

    private func calculateCompletion() -> CGFloat {
        guard totalSteps > 0 else { return 0 }
        return CGFloat(currentStep > totalSteps ? totalSteps : currentStep) / CGFloat(totalSteps)
    }

    private func calculateFillWidth(for availableWidth: CGFloat) -> CGFloat {
        return availableWidth * calculateCompletion()
    }
}

#Preview {
    
    VStack(spacing: 32) {
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 0)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 20)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 12)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 32)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 5)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 0)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(.horizontal, 32)
        
        ProgressBar(text: "Ποτήρια Νερό", totalSteps: 32, currentStep: 45)
            .padding(.horizontal, 32)
    }
}
