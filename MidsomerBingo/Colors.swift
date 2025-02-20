//
//  Colors.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&value)
        
        let r, g, b, a: Double
        switch cleanHex.count {
        case 6:
            r = Double((value >> 16) & 0xFF) / 255.0
            g = Double((value >> 8) & 0xFF) / 255.0
            b = Double(value & 0xFF) / 255.0
            a = 1.0
        case 8:
            r = Double((value >> 24) & 0xFF) / 255.0
            g = Double((value >> 16) & 0xFF) / 255.0
            b = Double((value >> 8) & 0xFF) / 255.0
            a = Double(value & 0xFF) / 255.0
        default:
            r = 0.0
            g = 0.0
            b = 0.0
            a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

struct Colors {
    static let primary = Color(hex: "#FFFDD0")
    static let secondary = Color(hex: "#93FAA5")
    static let tertiary = Color(hex: "#404D3D")
    static let background = Color(hex: "#B5C0C9")
    static let shadow = Color(hex: "#B5C0C9")
    static let text = Color(hex: "#2E3134")
}
