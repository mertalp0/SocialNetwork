//
//  UserModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation

struct AppUser {
    let id: String
    let username: String
    let nickname: String
    let email: String
    let password: String
    let aboutMe: String
    let profileImageUrl: String
    var posts: [String]
    let followers: [String]
    let following: [String]
    
    init(id: String,
         username: String,
         nickname: String,
         email: String,
         password: String,
         aboutMe: String,
         profileImageUrl: String,
         posts: [String] = [],
         followers: [String] = [],
         following: [String] = []) {
        
        self.id = id
        self.username = username
        self.nickname = nickname
        self.email = email
        self.password = password
        self.aboutMe = aboutMe
        self.profileImageUrl = profileImageUrl
        self.posts = posts
        self.followers = followers
        self.following = following
    }
}
