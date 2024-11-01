//
//  ValidationManager.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import Foundation

class ValidationManager {
    
   
    func validateEmail(_ email: String) -> Bool {
        guard !email.isEmpty else {
            print("Validation Error: Email is required.")
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailPredicate.evaluate(with: email)
        
        if !isValid {
            print("Validation Error: Invalid email format.")
        }
        
        return isValid
    }
    
   
    func validatePassword(_ password: String, minLength: Int = 6) -> Bool {
        guard password.count >= minLength else {
            print("Validation Error: Password must be at least \(minLength) characters long.")
            return false
        }
        return true
    }
    
    // Kullanıcı adı doğrulama fonksiyonu
    func validateUsername(_ username: String) -> Bool {
        guard !username.isEmpty else {
            print("Validation Error: Username is required.")
            return false
        }
        return true
    }
    
    // Takma ad doğrulama fonksiyonu
    func validateNickname(_ nickname: String) -> Bool {
        guard !nickname.isEmpty else {
            print("Validation Error: Nickname is required.")
            return false
        }
        return true
    }
}
