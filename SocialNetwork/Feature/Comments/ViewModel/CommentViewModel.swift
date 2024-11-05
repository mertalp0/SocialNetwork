//
//  CommentViewModel.swift
//  SocialNetwork
//

import Foundation

final class CommentViewModel: BaseViewModel {
    
    
    var post : Post?
    var comments : [Comment] = []
    
    init(post: Post? = nil) {
        self.post = post
    }
    
    private var user = UserManager.shared.currentUser
    
    private let commentService = CommentService()
    
    func fetchComments(commentIds: [String], completion: @escaping (Bool) -> Void) {
        startLoading()
        commentService.getComments(byIds: commentIds) { [weak self] result in
            self?.startLoading()
            switch result {
            case .success(let fetchedComments):
                self?.comments = fetchedComments
                completion(true)
            case .failure(let error):
                print("Error fetching comments: \(error.localizedDescription)")
                self?.triggerAlert(title: "Error", message: error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func pushComment(text: String, completion: @escaping (Bool) -> Void) {
        startLoading()
        let comment = Comment(id: UUID().uuidString, userId: user!.id, postId: post!.id, username: user!.username, nickname: user!.nickname, userImageUrl: user!.profileImageUrl, createdAt: Date(), commentText: text)
        
        commentService.pushComment(comment: comment) { result in
            self.stopLoading()
            switch result {
            case .success:
                self.triggerAlert(title: "Success", message: "post shared successfully")
                completion(true)
            case .failure(let error):
                print("Error sending comment: \(error.localizedDescription)")
                self.triggerAlert(title: "Error", message: error.localizedDescription)
                completion(false)
            }
        }
    }
}
