//  ImageManager.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import UIKit

final class ImageManager {
    
    // MARK: - Singleton
    static let shared = ImageManager()
    
    private init() {}
    
    // MARK: - App Icons
    enum AppIcons: String {
        case profilePlaceholder = "person.crop.circle.fill.badge.plus"
        case backButtonIcon = "chevron.backward"
    }
    
    func getImage(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
    
    // MARK: - App Images
    enum AppImages: String {
        case appleIcon = "apple_icon"
        case googleIcon = "google_icon"
        case mert = "Mert"
    }
    
    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}
