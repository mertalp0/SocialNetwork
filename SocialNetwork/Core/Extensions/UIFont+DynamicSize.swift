//
//  UIFont+DynamicSize.swift
//  BaseExample
//
//  Created by mert alp on 28.10.2024.
//

import UIKit

enum FontSize {
    case title, body, caption
    
    var value: CGFloat {
        switch self {
        case .title: return 24
        case .body: return 16
        case .caption: return 12
        }
    }
}

extension UIFont {
    static func dynamicFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size * UIScreen.heightRatio, weight: weight)
    }
}
