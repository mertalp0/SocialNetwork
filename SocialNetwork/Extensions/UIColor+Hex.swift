//
//  UIColor+Hex.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import UIKit

extension UIColor {
    /// HEX renk koduyla UIColor oluşturur
    /// Örnek: UIColor(hex: "#51d266") veya UIColor(hex: "51d266")
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}