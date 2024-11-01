//
//  BaseViewModel.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

protocol BaseViewModelProtocol {
    
}

class BaseViewModel : BaseViewModelProtocol {
    
    let networkManager : NetworkManager = NetworkManager()
    
    var isLoading : ((Bool) -> Void)?
    var showAlert : ((String, String) -> Void)?
    
    var isConnectedToNetwork: Bool {
            return NetworkManager.isConnectedToInternet()
        }
    
    
    func startLoading(){
        isLoading?(true)
    }
    
    func stopLoading(){
        isLoading?(false)
    }
    
    func triggerAlert(title: String, message: String) {
           showAlert?(title, message)
    }
    
    
    
}
