//
//  ChartsBar.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 15/1/24.
//

import SwiftUI
import Charts

struct ChartsBar: View {
    
    struct Item: Identifiable {
        let id = UUID()
        let habitName: String
        let value: Int
    }
    
    private var dayData: [Item]
    private var weekData: [Item]
    private var habitStatData: [(groupName: String, data: [Item])]
    
    init(dayData: [Item], weekData: [Item]) {
        self.dayData = dayData
        self.weekData = weekData
        
        habitStatData = [
            (groupName: "Daily", data: dayData),
            (groupName: "Weekly", data: weekData)]
    }
    
    
    var body: some View {
        
        // Source: https://www.devtechie.com/community/public/posts/154178-new-in-swiftui-4-multi-series-bar-chart
        
        Chart {
            ForEach(habitStatData, id: \.groupName) { element in
                ForEach(element.data) {
                    BarMark(x: .value("", $0.value), y: .value("", $0.habitName))
                        
                }
                .foregroundStyle(by: .value("", element.groupName))
                .position(by: .value("", element.groupName))
            }
        }
        .chartXAxis(.hidden)
        .chartLegend(.hidden)
        .frame(height: 80 * CGFloat(dayData.count))

        .chartForegroundStyleScale([
            "Daily": Color(hex: "5087EC"),
            "Weekly": Color(hex: "67BBC4")])
    }
}

#Preview {
    ChartsBar(
        dayData: [
            .init(habitName: "Ποτήρια Νερό", value: 23),
            .init(habitName: "Λεπτά Περπάτημα", value: 35)
        ],
        weekData: [
            .init(habitName: "Ποτήρια Νερό", value: 33),
            .init(habitName: "Λεπτά Περπάτημα", value: 12)
        ]
    )
    .padding(16)
}
