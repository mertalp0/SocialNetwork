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
    
    // MARK: - Gönderi Oluşturma
    func createPost() {
        startLoading()
        
        // Resim varsa önce resim yüklemesini yap
        if let image = image {
            handleImageUpload(image: image)
        } else {
            // Resim yoksa doğrudan gönderiyi kaydet
            savePost(imageUrl: nil)
        }
    }
    
    // MARK: - Resim Yükleme İşlemi
    private func handleImageUpload(image: UIImage) {
        imageService.uploadImage(image: image) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                // Resim yükleme başarılıysa gönderiyi resim URL'si ile kaydet
                self?.savePost(imageUrl: imageUrl)
                
            case .failure(let error):
                // Resim yükleme başarısızsa kullanıcıya hata mesajı göster
                self?.stopLoading()
                self?.triggerAlert(title: "Image Upload Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Gönderiyi Firestore'a Kaydetme
    private func savePost(imageUrl: String?) {
        // Yeni Post modelini oluştur
        let postId = UUID().uuidString
        let post = Post(
            id: postId,
            userId: currentUser!.id,
            userImageUrl: currentUser!.profileImageUrl,
            username: currentUser!.username,
            userNickname: currentUser!.nickname,
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
                // Başarılı kayıttan sonra kullanıcıya post ID'sini ekle
                self?.updateUserPosts(with: postId)
                
            case .failure(let error):
                self?.triggerAlert(title: "Post Creation Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Kullanıcının Post Listesini Güncelleme
    private func updateUserPosts(with postId: String) {
        guard var user = currentUser else { return }
        
        user.posts.append(postId)
        userService.updateUserPosts(userId: user.id, posts: user.posts) { [weak self] result in
            switch result {
            case .success:
                UserManager.shared.appendPostToCurrentUser(postId)
                self?.triggerAlert(title: "Success", message: "Post created success")
            case .failure(let error):
                self?.triggerAlert(title: "User Update Error", message: error.localizedDescription)
            }
        }
    }
}
