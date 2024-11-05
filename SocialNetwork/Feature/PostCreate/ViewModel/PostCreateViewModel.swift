//
//  PostCreateViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit

final class PostCreateViewModel: BaseViewModel {
    
    private let postService = PostService()
    private let imageService = ImageService()
    private let userService = UserService()
    private let currentUser = UserManager.shared.currentUser
    
    var text: String = ""
    var image: UIImage?
    
    // MARK: - Create Post
    func createPost() {
        startLoading()
        if let image = image {
            handleImageUpload(image: image)
        } else {
            savePost(imageUrl: nil)
        }
    }
    
    // MARK: - Image Upload Handling
    private func handleImageUpload(image: UIImage) {
        imageService.uploadImage(image: image) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                self?.savePost(imageUrl: imageUrl)
            case .failure(let error):
                self?.stopLoading()
                self?.triggerAlert(title: "Image Upload Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Save Post to Firestore
    private func savePost(imageUrl: String?) {
        guard let currentUser = currentUser else { return }
        
        let post = Post(
            id: UUID().uuidString,
            userId: currentUser.id,
            userImageUrl: currentUser.profileImageUrl,
            username: currentUser.username,
            userNickname: currentUser.nickname,
            text: text,
            imageUrl: imageUrl,
            likers: [],
            commenters: [],
            createdAt: Date()
        )
        
        postService.savePost(post: post) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success:
                self?.updateUserPosts(with: post.id)
            case .failure(let error):
                self?.triggerAlert(title: "Post Creation Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Update User's Post List
    private func updateUserPosts(with postId: String) {
        guard var user = currentUser else { return }
        
        user.posts.append(postId)
        userService.updateUserPosts(userId: user.id, posts: user.posts) { [weak self] result in
            switch result {
            case .success:
                UserManager.shared.appendPostToCurrentUser(postId)
                self?.triggerAlert(title: "Success", message: "Post created successfully.")
            case .failure(let error):
                self?.triggerAlert(title: "User Update Error", message: error.localizedDescription)
            }
        }
    }
}
