//
//  ChartsPie.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI
import Charts

struct ChartsPie: View {

    struct ShapeModel: Identifiable {
        var type: String
        var count: Double
        var id = UUID()
    }
    
    var data: [ShapeModel]
    
    init(data: [ShapeModel]) {
        self.data = data
    }
    
    var body: some View {
        
        // Source: https://stackoverflow.com/questions/73742810/swift-charts-ios-16-pie-donut-chart
        
        Chart(data, id: \.id) { element in
            SectorMark(
                angle: .value("Count", element.count),
                angularInset: 2.0
            )
            .foregroundStyle(by: .value("Type", element.type))
            .annotation(position: .overlay, alignment: .center) {
                VStack {
                    Text(element.type)
                        .font(.caption)
                    Text("\(element.count, format: .number.precision(.fractionLength(0)))")
                        .font(.caption)
                }
            }
        }
        .chartLegend(.hidden)
    }
}

#Preview {
    ChartsPie(data: [
        ChartsPie.ShapeModel(type: "Circle",    count: 12),
        ChartsPie.ShapeModel(type: "Square",    count: 10),
        ChartsPie.ShapeModel(type: "Triangle",  count: 21),
        ChartsPie.ShapeModel(type: "Rectangle", count: 15),
        ChartsPie.ShapeModel(type: "Hexagon",   count: 8)
    ])
    .padding(32)
}
