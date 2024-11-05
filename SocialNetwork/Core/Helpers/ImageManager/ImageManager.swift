//
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
        case play = "play.fill"
    }
    
    func getImage(named name: AppIcons) -> UIImage? {
        return UIImage(systemName: name.rawValue)
    }
    
    // MARK: - App Images
    enum AppImages: String {
        case applause = "applause"
    }
    
    func getImage(for image: AppImages) -> UIImage? {
        return UIImage(named: image.rawValue)
    }
}
