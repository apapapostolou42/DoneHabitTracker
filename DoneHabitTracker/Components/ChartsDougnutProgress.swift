//
//  ChartsDougnutProgress.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI
import Charts

struct ChartsDougnutProgress: View {
    
    private struct Item : Identifiable, Hashable {
        let id: UUID = UUID()
        let name: String
        let value: Float
    }
    
    private var progress: Float
    private var progressColorLow: Color
    private var progressColorHigh: Color
    private var dougnhutRadius: CGFloat = 0.65
    
    private var data: [Item]
    
    init(percentage: Float, progressColorLow: Color = .appYellow, progressColorHigh: Color = .appGreenLight, dougnhutRadius: CGFloat = 0.65) {
        self.progress = min(max(percentage, 0), 100)
        self.progressColorLow = progressColorLow
        self.progressColorHigh = progressColorHigh
        self.dougnhutRadius = dougnhutRadius
        
        data = [
            Item(name: "1", value: progress),
            Item(name: "0", value: 100 - progress)
        ]
    }
    
    var body: some View {
        Chart(data) { element in
            SectorMark(
                angle: .value("", element.value),
                innerRadius: .ratio(dougnhutRadius),
                angularInset: 0.0
            )
            .foregroundStyle(by: .value("Type", element.name))
        }
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                VStack {
                    Text(String(format: "%.0f%%", progress))
                        .font(.title)
                        .foregroundStyle(.primary)
                }
                .position(
                    x: frame.midX,
                    y: frame.midY
                )
            }
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale([
            "1": progress <= 50.0 ? progressColorLow : progressColorHigh,
            "0": Color.gray.opacity(0.3)])
    }
}

#Preview {
    ChartsDougnutProgress(percentage: 82.0)
        .padding(92)
}
