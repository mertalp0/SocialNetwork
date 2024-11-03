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
    
    // MARK: - Belirli Post ID'leriyle Gönderileri Çekme
        func fetchPostsByIds(postIds: [String], completion: @escaping (Result<[Post], Error>) -> Void) {
            
            guard !postIds.isEmpty else {
                completion(.success([])) // Boş bir dizi gönderilirse boş sonuç döner
                return
            }
            
            var fetchedPosts: [Post] = []
            let group = DispatchGroup()
            
            for postId in postIds {
                group.enter()
                db.collection("posts").document(postId).getDocument { document, error in
                    defer { group.leave() }
                    
                    if let document = document, document.exists {
                        if let post = try? document.data(as: Post.self) {
                            fetchedPosts.append(post)
                        }
                    } else if let error = error {
                        print("Error fetching post with id \(postId): \(error)")
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(.success(fetchedPosts))
            }
        }
}
