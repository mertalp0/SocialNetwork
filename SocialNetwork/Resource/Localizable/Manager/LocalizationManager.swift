//
//  LocalizationManager.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation

final class LocalizationManager {
    
    // Singleton instance
    static let shared = LocalizationManager()
    
    // App Strings
    enum LocalizationKeys {
        static let welcomeMessage = "welcome_message"
    }
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    // Localized string fetcher
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    
    func welcomeMessage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.welcomeMessage)
    }
}
