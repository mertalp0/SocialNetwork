//
//  LoginViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel: BaseViewModel {
    
    // MARK: - Properties
    var email: String = ""
    var password: String = ""
    
    private let authService = AuthService.shared
    private let userService = UserService()
    private let validationManager = ValidationManager()
    
    // MARK: - Input Validation
    private func validateInputs() -> Bool {
        let isEmailValid = validationManager.validateEmail(email)
        let isPasswordValid = validationManager.validatePassword(password)
        
        if !isEmailValid {
            triggerAlert(title: l10n.validationErrorTitle(), message: l10n.invalidEmailMessage())
        }
        
        if !isPasswordValid {
            triggerAlert(title: l10n.validationErrorTitle(), message: l10n.invalidPasswordMessage())
        }
        
        return isEmailValid && isPasswordValid
    }
    
    // MARK: - Login Function
    func login(completion: @escaping (Result<AppUser, Error>) -> Void) {
        guard validateInputs() else { return }
        
        startLoading()
        
        authService.login(email: email, password: password) { [weak self] result in
            self?.stopLoading()
            
            switch result {
            case .success(let user):
                self?.fetchAndSetUser(userId: user.uid, completion: completion)
                
            case .failure(let error):
                self?.triggerAlert(title: self!.l10n.loginErrorTitle(), message: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Fetch and Set User Data
    private func fetchAndSetUser(userId: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        userService.getUser(id: userId) { [weak self] result in
            switch result {
            case .success(let appUser):
                UserManager.shared.setUser(appUser)
                completion(.success(appUser))
                
            case .failure:
                self?.triggerAlert(title: self!.l10n.userFetchErrorTitle(), message: self!.l10n.userFetchErrorMessage())
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: self!.l10n.userFetchErrorMessage()])))
            }
        }
    }
}
