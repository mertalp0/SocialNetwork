//
//  CommentViewModel.swift
//  SocialNetwork
//

import Foundation

final class CommentViewModel: BaseViewModel {
    
    var post: Post?
    var comments: [Comment] = []
    
    private var user: AppUser? {
        return UserManager.shared.currentUser
    }
    
    private let commentService = CommentService()
    
    init(post: Post? = nil) {
        super.init()
        self.post = post
        if let commentIds = post?.commenters {
            self.fetchComments(commentIds: commentIds) { _ in }
        }
    }
    
    func fetchComments(commentIds: [String], completion: @escaping (Bool) -> Void) {
        startLoading()
        
        commentService.getComments(byIds: commentIds) { [weak self] result in
           
            self?.stopLoading()
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
        guard let user = user, let post = post else {
            triggerAlert(title: "Error", message: "User or Post not found")
            completion(false)
            return
        }
        
        startLoading()
        
        let comment = Comment(
            id: UUID().uuidString,
            userId: user.id,
            postId: post.id,
            username: user.username,
            nickname: user.nickname,
            userImageUrl: user.profileImageUrl,
            createdAt: Date(),
            commentText: text
        )
        
        commentService.pushComment(comment: comment) { [weak self] result in
            self?.stopLoading()
            
            switch result {
            case .success:
                self?.triggerAlert(title: "Success", message: "Comment posted successfully")
                self?.comments.append(comment)
                completion(true)
            case .failure(let error):
                print("Error sending comment: \(error.localizedDescription)")
                self?.triggerAlert(title: "Error", message: error.localizedDescription)
                completion(false)
            }
        }
    }
}
