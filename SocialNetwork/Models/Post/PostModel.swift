//
//  PostModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation

struct PostModel {
    let profileImageName: String?
    let username: String
    let handle: String
    let date: String
    let content: String
    let postImageName: String?
    let likeCount: Int
    let commentCount: Int
}


struct Post {
    let id: String
    let userId: String
    let userImageUrl: String
    let username: String
    let userNickname: String
    let text: String
    let imageUrl: String? // Opsiyonel resim URL
    let likers: [String] // Beğenen kullanıcı ID'leri
    let commenters: [String] // Yorum yapan kullanıcı ID'leri
    let createdAt: Date
    
    init(id: String,
         userId: String,
         userImageUrl: String,
         username: String,
         userNickname: String,
         text: String,
         imageUrl: String? = nil,
         likers: [String] = [],
         commenters: [String] = [],
         createdAt: Date = Date()) {
        
        self.id = id
        self.userId = userId
        self.userImageUrl = userImageUrl
        self.username = username
        self.userNickname = userNickname
        self.text = text
        self.imageUrl = imageUrl
        self.likers = likers
        self.commenters = commenters
        self.createdAt = createdAt
    }
}
