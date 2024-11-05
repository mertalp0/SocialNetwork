//
//  CommentViewModel.swift
//  SocialNetwork
//

import Foundation

final class CommentViewModel: BaseViewModel {
    
    private let commentService = CommentService()
    
    func fetchComments(completion: @escaping ([Comment]) -> Void) {
//        commentService.getComments(for: postID) { result in
//            switch result {
//            case .success(let comments):
//                completion(comments)
//            case .failure(let error):
//                print("Error fetching comments: \(error.localizedDescription)")
//                completion([])
//            }
//        }
    }
    
    func sendComment(text: String, completion: @escaping (Bool) -> Void) {
//        let comment = Comment(id: UUID().uuidString, userId: currentUser.id, username: currentUser.username, nickname: currentUser.nickname, userImageUrl: currentUser.profileImageUrl, createdAt: Date(), commentText: text)
//        
//        commentService.pushComment(comment: comment) { result in
//            switch result {
//            case .success:
//                completion(true)
//            case .failure(let error):
//                print("Error sending comment: \(error.localizedDescription)")
//                completion(false)
//            }
//        }
    }
}
