//
//  SignupViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation

class SignupViewModel: BaseViewModel {
    
    private let signupService = AuthService()
    private let validationManager = ValidationManager()
    
    var username: String = ""
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var aboutMe: String = ""
    
    // Doğrulama işlemi
    func validateInputs() -> Bool {
        let isUsernameValid = validationManager.validateUsername(username)
        let isNicknameValid = validationManager.validateNickname(nickname)
        let isEmailValid = validationManager.validateEmail(email)
        let isPasswordValid = validationManager.validatePassword(password)
        
        if !isUsernameValid || !isNicknameValid || !isEmailValid || !isPasswordValid {
            triggerAlert(title: "Validation Error", message: "Please make sure all fields are valid.")
            return false
        }
        
        return true
    }
    
    func signUp() {
        guard validateInputs() else { return }
        startLoading()
        
        signupService.signUp(email: email, password: password) { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success(let user):
                print(user)
                self?.triggerAlert(title: "Success", message: "You can login now.")
                
            case .failure(let error):
                print(error)
                self?.triggerAlert(title: "Signup Error", message: error.localizedDescription)
                
            }
        }
    }
}
