//
//  Color+Extensions.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 15/1/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }

        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r, g, b, a: Double
        if hexString.count == 6 {
            r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
            g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
            b = Double(hexNumber & 0x0000FF) / 255.0
            a = 1.0
        } else if hexString.count == 8 {
            r = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            g = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
            b = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
            a = Double(hexNumber & 0x000000FF) / 255.0
        } else {
            // Invalid hex string, default to black color
            r = 0.0
            g = 0.0
            b = 0.0
            a = 1.0
        }
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
    
    static let appRed = Color(hex: "EE958D")
    static let appGreenLight = Color(hex: "0AE629")
    static let appGreenDeep = Color(hex: "15C203")
    static let appYellow = Color(hex: "E5F01A")
    
    static let btnEnabled: Color = .blue
    static let btnDisabled: Color = .gray
}
