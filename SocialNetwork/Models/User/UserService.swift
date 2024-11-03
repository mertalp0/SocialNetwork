//
//  UserService.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//


import Foundation
import FirebaseFirestore

class UserService {
    private let db = Firestore.firestore()
    private let usersCollection = "users"
        
    init(){}
    
    // MARK: - Save User to Firestore
    func saveUser(user: AppUser, completion: @escaping (Result<Void, Error>) -> Void) {
        let userData: [String: Any] = [
            "id": user.id,
            "username": user.username,
            "nickname": user.nickname,
            "email": user.email,
            "password": user.password,
            "aboutMe": user.aboutMe,
            "profileImageUrl": user.profileImageUrl,
            "posts": user.posts,
            "followers": user.followers,
            "following": user.following
        ]
        
        db.collection(usersCollection).document(user.id).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: - Get User by ID
    func getUser(id: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        db.collection(usersCollection).document(id).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data(), let user = self.mapUser(data: data) else {
                completion(.failure(NSError(domain: "User Not Found", code: 404, userInfo: nil)))
                return
            }
            
            completion(.success(user))
        }
    }
    
    // MARK: - Fetch Multiple Users by IDs
    func fetchUsers(ids: [String], completion: @escaping (Result<[AppUser], Error>) -> Void) {
        let query = db.collection(usersCollection).whereField("id", in: ids)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "Users Not Found", code: 404, userInfo: nil)))
                return
            }
            
            let users = documents.compactMap { self.mapUser(data: $0.data()) }
            completion(.success(users))
        }
    }
    
    // MARK: - Map Firestore Data to AppUser
    private func mapUser(data: [String: Any]) -> AppUser? {
        guard
            let id = data["id"] as? String,
            let username = data["username"] as? String,
            let nickname = data["nickname"] as? String,
            let email = data["email"] as? String,
            let password = data["password"] as? String,
            let aboutMe = data["aboutMe"] as? String,
            let profileImageUrl = data["profileImageUrl"] as? String,
            let posts = data["posts"] as? [String],
            let followers = data["followers"] as? [String],
            let following = data["following"] as? [String]
        else {
            return nil
        }
        
        return AppUser(
            id: id,
            username: username,
            nickname: nickname,
            email: email,
            password: password,
            aboutMe: aboutMe,
            profileImageUrl: profileImageUrl,
            posts: posts,
            followers: followers,
            following: following
        )
    }
    
    func updateUserPosts(userId: String, posts: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = db.collection("users").document(userId)
        userRef.updateData(["posts": posts]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
