//
//  UserManager.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation

// MARK: - UserManager
final class UserManager {
    
    // MARK: - Properties
    static let shared = UserManager()
    
    private(set) var currentUser: AppUser? {
        didSet {
            NotificationCenter.default.post(name: .currentUserDidChange, object: nil)
        }
    }
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - User Management
    func setUser(_ user: AppUser) {
        currentUser = user
    }
    
    func clearUser() {
        currentUser = nil
    }
    
    func appendPostToCurrentUser(_ postId: String) {
        guard var user = currentUser else { return }
        user.posts.append(postId)
        currentUser = user
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    static let currentUserDidChange = Notification.Name("currentUserDidChange")
}
