//
//  BaseViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

protocol BaseViewModelProtocol { }

class BaseViewModel: BaseViewModelProtocol {
    
    var l10n: L10n {
           return L10n.shared
       }
    
    // MARK: - Properties
    let networkManager = NetworkManager()
    
    var isLoading: ((Bool) -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    // MARK: - Network Connectivity
    var isConnectedToNetwork: Bool {
        return NetworkManager.isConnectedToInternet()
    }
    
    // MARK: - Loading Methods
    func startLoading() {
        isLoading?(true)
    }
    
    func stopLoading() {
        isLoading?(false)
    }
    
    // MARK: - Alert Methods
    func triggerAlert(title: String, message: String) {
        showAlert?(title, message)
    }
}
