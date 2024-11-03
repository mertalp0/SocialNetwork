//
//  UserManager.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    private(set) var currentUser: AppUser? {
        didSet {
            NotificationCenter.default.post(name: .currentUserDidChange, object: nil)
        }
    }
    
    private init() {}
    
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

extension Notification.Name {
    static let currentUserDidChange = Notification.Name("currentUserDidChange")
}
