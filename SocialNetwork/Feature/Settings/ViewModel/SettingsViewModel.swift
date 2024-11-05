//
//  SettingsViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import Foundation

final class SettingsViewModel: BaseViewModel {
    
    // MARK: - Properties
    private let authService = AuthService.shared

    // MARK: - Logout Function
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        startLoading()
        
        authService.logout { [weak self] result in
            self?.stopLoading()
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                self?.triggerAlert(title: "Logout Error", message: error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
