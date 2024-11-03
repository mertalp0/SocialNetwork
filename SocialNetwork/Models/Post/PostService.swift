//
//  PostService.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation
import FirebaseFirestore

class PostService {
    private let db = Firestore.firestore()
    
    // MARK: - Post Kaydetme
    func savePost(post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        // Gönderiyi Firestore'a kaydetmek için id ile bir referans oluşturuyoruz
        let postRef = db.collection("posts").document(post.id)
        
        // Post verilerini sözlük formatında kaydediyoruz
        do {
            try postRef.setData(from: post) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Tüm Gönderileri Çekme
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts")
            .order(by: "createdAt", descending: true) // Tarihe göre sıralama
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([])) // Boş bir array döner
                    return
                }
                
                // Belgeleri `Post` modeline dönüştürme
                let posts = documents.compactMap { document -> Post? in
                    try? document.data(as: Post.self)
                }
                completion(.success(posts))
            }
    }
    
    // MARK: - Belirli Kullanıcının Gönderilerini Çekme
    func fetchPostsForUser(userId: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true) // Tarihe göre sıralama
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                // Belgeleri `Post` modeline dönüştürme
                let posts = documents.compactMap { document -> Post? in
                    try? document.data(as: Post.self)
                }
                completion(.success(posts))
            }
    }
}
