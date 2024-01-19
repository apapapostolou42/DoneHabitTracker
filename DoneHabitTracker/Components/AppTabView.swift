//
//  AppTabView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 19/1/24.
//

import SwiftUI

struct AppTabItem {
    let title: String
    let count: Int
}

struct AppTabView: View {
    let tabItems: [AppTabItem]
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabItems.indices, id: \.self) { index in
                Button(action: {
                    self.selectedTabIndex = index
                }) {
                    HStack {
                        Text(tabItems[index].title)
                            .font(.caption.bold())
                            .foregroundColor(selectedTabIndex == index ? .white : .primary)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: 25, height: 25)
                            
                            Text("\(tabItems[index].count)")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        .padding(8)
                        .opacity(tabItems[index].count == 0 ? 0.0 : 1.0)
                    }
                    .padding(.horizontal, 8)
                    
                    .frame(maxWidth: .infinity) // Ensure each tab item takes up equal space
                    .background(selectedTabIndex == index ? Color.red : Color.gray.opacity(0.5))
                    .overlay {
                        RoundedRectangle(cornerRadius: 0.0)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1.0)
                    }
                }
            }
        }
    }
}

#Preview {
   
    @State var selection: Int = 0
    
    let tabItems = [
        AppTabItem(title: "Today", count: 3),
        AppTabItem(title: "Week", count: 1),
        AppTabItem(title: "Month", count: 0)
    ]
    
    return AppTabView(tabItems: tabItems, selectedTabIndex: $selection)
        .padding()
        .background(Color.gray.opacity(0.2))
}
