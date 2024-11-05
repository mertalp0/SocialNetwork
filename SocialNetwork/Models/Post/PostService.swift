//
//  PostService.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation
import FirebaseFirestore

final class PostService {
    private let db = Firestore.firestore()
    
    // MARK: - Save Post
    func savePost(post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        let postRef = db.collection("posts").document(post.id)
        
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
    
    // MARK: - Fetch All Posts
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let posts = documents.compactMap { document -> Post? in
                    try? document.data(as: Post.self)
                }
                completion(.success(posts))
            }
    }
    
    // MARK: - Fetch Posts for Specific User
    func fetchPostsForUser(userId: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let posts = documents.compactMap { document -> Post? in
                    try? document.data(as: Post.self)
                }
                completion(.success(posts))
            }
    }
    
    // MARK: - Fetch Posts by IDs
    func fetchPostsByIds(postIds: [String], completion: @escaping (Result<[Post], Error>) -> Void) {
        
        guard !postIds.isEmpty else {
            completion(.success([]))
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
