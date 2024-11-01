//
//  BaseVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit

class BaseVC <TypeViewModel: BaseViewModel> : UIViewController {
    
    var viewModel : TypeViewModel
   
    
    private var loadingView: UIView?
    
    init(viewModel: TypeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Handle view WillAppear if needed
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Handle view appearance if needed
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Handle view disappearance if needed
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Handle view disappearance if needed
    }
}

//MARK: - Helpers
extension BaseVC {
    
       func dynamicHeight(_ height: CGFloat) -> CGFloat {
           return UIScreen.dynamicHeight(height)
       }
       
       func dynamicWidth(_ width: CGFloat) -> CGFloat {
           return UIScreen.dynamicWidth(width)
       }
       
       func font(for size: FontSize, weight: UIFont.Weight = .regular) -> UIFont {
           return UIFont.dynamicFont(size: size.value, weight: weight)
       }
}


//MARK: -  Loading
extension BaseVC {
    
    private func showLoading() {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = UIView(frame: self.view.bounds)
                self.loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.center = self.loadingView?.center ?? .zero
                activityIndicator.color = .white
                activityIndicator.startAnimating()
                self.loadingView?.addSubview(activityIndicator)
                self.view.addSubview(self.loadingView!)
            }
        }
    }
    
   private func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
}

//MARK: - Error alert
extension BaseVC {
    private func showAlert(title: String, message: String) {
           DispatchQueue.main.async {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               self.present(alert, animated: true, completion: nil)
           }
       }
}


// MARK: - Bind ViewModel
extension BaseVC {
    func bindViewModel() {
        
        viewModel.isLoading = { [weak self] isLoading in
            if isLoading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }
        
        viewModel.showAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
    }
}
