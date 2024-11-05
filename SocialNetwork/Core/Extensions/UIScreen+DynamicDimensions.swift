//
//  UIScreen+DynamicDimensions.swift
//  BaseExample
//
//  Created by mert alp on 28.10.2024.
//

import UIKit

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let heightRatio = UIScreen.screenHeight / 812
    static let widthRatio = UIScreen.screenWidth / 375
    
    static func dynamicHeight(_ height: CGFloat) -> CGFloat {
        return height * heightRatio
    }
    
    static func dynamicWidth(_ width: CGFloat) -> CGFloat {
        return width * widthRatio
    }
    
}
