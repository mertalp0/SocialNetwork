//
//  SignupViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation
import UIKit

class SignupViewModel: BaseViewModel {
    
    private let signupService = AuthService()
    private let validationManager = ValidationManager()
    private let userService = UserService()
    private let imageService = ImageService()
    
    var username: String = ""
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var aboutMe: String = ""
    var selectedImage: UIImage?
    
    // MARK: - Input Doğrulama
    func validateInputs() -> Bool {
        let isUsernameValid = validationManager.validateUsername(username)
        let isNicknameValid = validationManager.validateNickname(nickname)
        let isEmailValid = validationManager.validateEmail(email)
        let isPasswordValid = validationManager.validatePassword(password)
        
        if selectedImage == nil {
            triggerAlert(title: "Validation Error", message: "Please select a profile image.")
            return false
        }
        
        
        if !isUsernameValid || !isNicknameValid || !isEmailValid || !isPasswordValid {
            triggerAlert(title: "Validation Error", message: "Please make sure all fields are valid.")
            return false
        }
        
        return true
    }
    
    // MARK: - Signup İşlemi
    func signUp() {
        guard validateInputs() else { return }
        startLoading()
        
        // 1. Kullanıcıyı Firebase Auth'a kaydet
        signupService.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.handleImageUpload(for: user.uid)
                
            case .failure(let error):
                self?.stopLoading()
                self?.triggerAlert(title: "Signup Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Resim Yükleme İşlemi
    private func handleImageUpload(for userId: String) {
        // Eğer profil resmi seçilmediyse doğrudan Firestore'a kaydetme işlemini gerçekleştir
        guard let image = selectedImage else {
            saveUserToFirestore(userId: userId, profileImageUrl: "")
            return
        }
        
        // Profil resmini yükle
        imageService.uploadImage(image: image) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                // Resim URL'sini kullanarak Firestore'a kaydet
                self?.saveUserToFirestore(userId: userId, profileImageUrl: imageUrl)
                
            case .failure(let error):
                self?.stopLoading()
                self?.triggerAlert(title: "Image Upload Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Firestore'a Kullanıcı Bilgilerini Kaydetme
    private func saveUserToFirestore(userId: String, profileImageUrl: String) {
        
        let appUser = AppUser(
            id: userId,
            username: username,
            nickname: nickname,
            email: email,
            password: password,
            aboutMe: aboutMe,
            profileImageUrl: profileImageUrl,
            posts: [],             // Varsayılan olarak boş array
            followers: [],         // Varsayılan olarak boş array
            following: []          // Varsayılan olarak boş array
        )
        
        userService.saveUser(user: appUser) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success:
                self?.triggerAlert(title: "Success", message: "You can login now.")
                
            case .failure(let error):
                self?.triggerAlert(title: "Firestore Error", message: error.localizedDescription)
            }
        }
    }
}
