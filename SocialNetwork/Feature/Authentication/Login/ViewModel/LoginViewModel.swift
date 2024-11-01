//
//  LoginViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel: BaseViewModel {
    
    var email: String = ""
    var password: String = ""
    
    private let authService = AuthService()
    private let validationManager = ValidationManager()
    
    // Giriş doğrulama işlemi
    func validateInputs() -> Bool {
        let isEmailValid = validationManager.validateEmail(email)
        let isPasswordValid = validationManager.validatePassword(password)
        
        if !isEmailValid {
            triggerAlert(title: "Validation Error", message: "Invalid email format or empty.")
        }
        
        if !isPasswordValid {
            triggerAlert(title: "Validation Error", message: "Password must be at least 6 characters long.")
        }
        
        return isEmailValid && isPasswordValid
    }
    
    func login(completion: @escaping (Result<User, Error>) -> Void) {
        guard validateInputs() else { return }
        startLoading()
        
        authService.login(email: email, password: password) { [weak self] result in
            self?.stopLoading()
            
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                self?.triggerAlert(title: "Error", message: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
