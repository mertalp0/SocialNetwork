//
//  FeedViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation

final class FeedViewModel: BaseViewModel {
    
    private let postService = PostService()
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping () -> Void) {
        startLoading()
        
        postService.fetchPosts { [weak self] result in
            self?.stopLoading()
            
            switch result {
            case .success(let fetchedPosts):
                self?.posts = fetchedPosts
                completion()
                
            case .failure(let error):
                self?.triggerAlert(title: "Error", message: error.localizedDescription)
                completion()  
            }
        }
    }
}
