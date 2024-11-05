//
//  SignupViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation
import UIKit

class SignupViewModel: BaseViewModel {
    
    // MARK: - Properties
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
    
    // MARK: - Input Validation
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
    
    // MARK: - Signup Function
    func signUp() {
        guard validateInputs() else { return }
        startLoading()
        
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
    
    // MARK: - Image Upload Handling
    private func handleImageUpload(for userId: String) {
        guard let image = selectedImage else {
            saveUserToFirestore(userId: userId, profileImageUrl: "")
            return
        }
        
        imageService.uploadImage(image: image) { [weak self] result in
            switch result {
            case .success(let imageUrl):
                self?.saveUserToFirestore(userId: userId, profileImageUrl: imageUrl)
                
            case .failure(let error):
                self?.stopLoading()
                self?.triggerAlert(title: "Image Upload Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Save User to Firestore
    private func saveUserToFirestore(userId: String, profileImageUrl: String) {
        let appUser = AppUser(
            id: userId,
            username: username,
            nickname: nickname,
            email: email,
            password: password,
            aboutMe: aboutMe,
            profileImageUrl: profileImageUrl,
            posts: [],
            followers: [],
            following: []
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
