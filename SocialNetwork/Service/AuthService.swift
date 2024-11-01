//
//  AuthService.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
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
                completion(.success(user))
            }
        }
    }
    
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
                completion(.success(user))
            }
        }
    }
}
