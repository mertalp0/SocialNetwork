//
//  LocalizationManager.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation

final class LocalizationManager {
    
    // MARK: - Singleton
    static let shared = LocalizationManager()
    
    private init() {}
    
    // MARK: - Localization Keys
    enum LocalizationKeys {
        static let welcomeMessage = "welcome_message"
    }
    
    // MARK: - Localized String Fetcher
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // MARK: - Localized Messages
    func welcomeMessage() -> String {
        return LocalizationManager.localizedString(forKey: LocalizationKeys.welcomeMessage)
    }
}
