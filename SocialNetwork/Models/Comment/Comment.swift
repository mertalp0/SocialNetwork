//
//  Comment.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import Foundation

struct Comment: Codable {
    var id: String
    var userId: String
    var username: String
    var nickname: String
    var userImageUrl: String
    var createdAt: Date
    var commentText: String
    
    init(
        id: String,
        userId: String,
        username: String,
        nickname: String,
        userImageUrl: String,
        createdAt: Date = Date(),
        commentText: String
    ) {
        self.id = id
        self.userId = userId
        self.username = username
        self.nickname = nickname
        self.userImageUrl = userImageUrl
        self.createdAt = createdAt
        self.commentText = commentText
    }
}
