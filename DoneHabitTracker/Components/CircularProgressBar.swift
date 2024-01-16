//
//  CircularProgressBar.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 15/1/24.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: CGFloat // the progress as a CGFloat, where 1.0 is 100%
    var progressColorLow: Color
    var progressColorHigh: Color
    var borderColor: Color = .gray
    
    /// completion between 0.0 .. 1.0
    init(completion: CGFloat, progressColorLow: Color = .appYellow, progressColorHigh: Color = .appGreenLight, borderColor: Color = .gray) {
        self.progress = completion
        self.progressColorLow = progressColorLow
        self.progressColorHigh = progressColorHigh
        self.borderColor = borderColor
    }
    
    /// percentage between 0..100
    init(percentage: CGFloat, progressColorLow: Color = .appYellow, progressColorHigh: Color = .appGreenLight, borderColor: Color = .gray) {
        self.progress = percentage/100.0
        self.progressColorLow = progressColorLow
        self.progressColorHigh = progressColorHigh
        self.borderColor = borderColor
    }

    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .background(Color.clear)
                .foregroundColor(Color.gray)

            // Foreground Circle
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .butt, lineJoin: .round))
                .foregroundColor(progress <= 0.5 ? progressColorLow : progressColorHigh )
                .rotationEffect(Angle(degrees: 270.0)) // Start the progress from the top
                .animation(.linear, value: progress)

            // Percentage Text
            Text(String(format: "%.0f%%", progress * 100))
                .font(.title)
                .foregroundColor(Color.primary)
        }
        .padding(10)
    }
}

#Preview {
    
    CircularProgressBar(percentage: 79)
        .frame(width: 120, height: 120)
    
}
