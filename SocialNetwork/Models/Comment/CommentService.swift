//
//  CommentService.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import FirebaseFirestore

final class CommentService {
    
    private let db = Firestore.firestore()
    private let commentsCollection = "comments"
    
    // MARK: - Push Comment
    func pushComment(comment: Comment, completion: @escaping (Result<Void, Error>) -> Void) {
        let commentId = comment.id
        let commentData: [String: Any] = [
            "id": commentId,
            "userId": comment.userId,
            "postId": comment.postId,
            "username": comment.username,
            "nickname": comment.nickname,
            "userImageUrl": comment.userImageUrl,
            "createdAt": comment.createdAt,
            "commentText": comment.commentText
        ]
        
        db.collection(commentsCollection).document(commentId).setData(commentData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
               
                self.db.collection("posts").document(comment.postId).updateData([
                    "commenters": FieldValue.arrayUnion([commentId])
                ]) { postError in
                    if let postError = postError {
                        completion(.failure(postError))
                    } else {
                        
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    // MARK: - Get Comments by IDs
    func getComments(byIds commentIds: [String], completion: @escaping (Result<[Comment], Error>) -> Void) {
        guard !commentIds.isEmpty else {
            completion(.success([]))
            return
        }
        
        var fetchedComments: [Comment] = []
        let group = DispatchGroup()
        
        for commentId in commentIds {
            group.enter()
            
            db.collection(commentsCollection).document(commentId).getDocument { document, error in
                defer { group.leave() }
                
                if let document = document, document.exists, let data = document.data() {
                    if let comment = self.mapComment(data: data) {
                        fetchedComments.append(comment)
                    }
                } else if let error = error {
                    print("Error fetching comment with id \(commentId): \(error)")
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(fetchedComments))
        }
    }
        
}

extension CommentService {
    // MARK: - Map Firestore Data to Comment
    private func mapComment(data: [String: Any]) -> Comment? {
        
        guard
            let id = data["id"] as? String,
            let userId = data["userId"] as? String,
            let postId = data["postId"] as? String,
            let username = data["username"] as? String,
            let nickname = data["nickname"] as? String,
            let userImageUrl = data["userImageUrl"] as? String,
            let createdAt = data["createdAt"] as? Timestamp,
            let commentText = data["commentText"] as? String
        else {
            return nil
        }
        
        return Comment(
            id: id,
            userId: userId,
            postId: postId,
            username: username,
            nickname: nickname,
            userImageUrl: userImageUrl,
            createdAt: createdAt.dateValue(),
            commentText: commentText
        )
    }
}
