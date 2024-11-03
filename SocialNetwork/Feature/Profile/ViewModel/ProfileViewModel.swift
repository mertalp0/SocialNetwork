//
//  ProfileViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import Foundation

final class ProfileViewModel: BaseViewModel {
    
    private let postService = PostService()
    var posts: [Post] = []
   

    // Kullanıcının gönderi ID'lerine göre gönderilerini çek
    func fetchPostsForUserIds(user: AppUser,completion: @escaping () -> Void) {
        startLoading()
        
        postService.fetchPostsByIds(postIds: user.posts) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let fetchedPosts):
                self?.posts = fetchedPosts.sorted(by: { $0.createdAt > $1.createdAt }) // Tarihe göre sırala
                completion()
            case .failure(let error):
                self?.triggerAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
