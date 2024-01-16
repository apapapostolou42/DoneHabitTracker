//
//  AppTextField.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 16/1/24.
//

import SwiftUI

struct AppTextField: View {
    @Binding private var text: String
    private let hint: String
    private let borderColor: Color
    private let borderWidth: CGFloat
    private let cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    init(hint: String = "", text: Binding<String>, borderColor: Color = .secondary, borderWidth: CGFloat = 2.0, cornerRadius: CGFloat = 5.0) {
        self.hint = hint
        self._text = text
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
                .background(RoundedRectangle(cornerRadius: 8).fill(colorScheme == .dark ? .black : .white))
                .frame(height: 40 - borderWidth * 2)
            
            TextField(hint.localized, text: $text)
                .padding(.horizontal, 8)
                .padding(.vertical, borderWidth)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, borderWidth)
        
    }
}

#Preview {
    VStack {
        AppTextField(hint: "Enter Value", text: .constant(""), borderColor: .secondary, borderWidth: 2.0)
        
        AppTextField(hint: "Enter Value", text: .constant("xxx"), borderColor: .secondary, borderWidth: 2.0)
    }
    .padding(32)
}
