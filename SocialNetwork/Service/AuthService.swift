//
//  AuthService.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    // Güncel oturum açmış kullanıcı
    var currentUser: User?
    
    // MARK: - Kayıt İşlemi
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard NetworkManager.isConnectedToInternet() else {
            let error = NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey: "No internet connection."])
            completion(.failure(error))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                // currentUser olarak atama
                self.currentUser = user
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Giriş İşlemi
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard NetworkManager.isConnectedToInternet() else {
            let error = NSError(domain: "", code: -1009, userInfo: [NSLocalizedDescriptionKey: "No internet connection."])
            completion(.failure(error))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                self.currentUser = user
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Kullanıcıyı Çıkış Yaptırma
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
  
}
