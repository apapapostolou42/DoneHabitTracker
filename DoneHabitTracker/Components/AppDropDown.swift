//
//  AppDropDown.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct AppDropDown: View {
    @Binding var selectedItem: String
    private let options: [String]
    private let onSelection: (String) -> Void
    private let borderColor: Color
    private let borderWidth: CGFloat
    private let cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    init(selectedItem: Binding<String>, options: [String], borderColor: Color = .secondary, borderWidth: CGFloat = 2.0, cornerRadius: CGFloat = 5.0, onSelection: @escaping (String) -> Void = {_ in} ) {
        
        self._selectedItem = selectedItem
        self.options = options
        self.onSelection = onSelection
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option.localized) {
                    self.selectedItem = option
                    self.onSelection(option)
                }
            }
        } label: {
            HStack {
                Text(selectedItem.localized)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(.primary)
            }
            .padding(8)
            .background(colorScheme == .dark ? .black : .white)
            .cornerRadius(cornerRadius)
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.secondary, lineWidth: borderWidth)
        )
    }
}

#Preview {
    AppDropDown(selectedItem: .constant("first"), options: ["first", "second", "third"]) { value in
        
    }
    .padding(32)
}
