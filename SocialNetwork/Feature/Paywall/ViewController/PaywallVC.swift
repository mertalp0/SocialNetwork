//
//  PaywallVC.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import SnapKit
import NeonSDK

class PaywallVC: BaseVC<PaywallViewModel> {
    
    private var premiumButton: CustomButton!
    private var basicButton: CustomButton!
    var canDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupButtons()
    }
    
    private func setupButtons() {
        premiumButton = CustomButton(title: "Premium", backgroundColor: .white, type: .large, textColor: .systemPink)
        premiumButton.delegate = self
        view.addSubview(premiumButton)
        
        basicButton = CustomButton(title: "Without Premium", backgroundColor: .white, type: .large, textColor: .systemGray)
        basicButton.delegate = self
        view.addSubview(basicButton)
        
        premiumButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        basicButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(premiumButton.snp.bottom).offset(20)
        }
    }
}

// MARK: - CustomButtonDelegate
extension PaywallVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        if button == premiumButton {
            if(canDismiss){
                Neon.isUserPremium = true
                dismiss(animated: true)
            }else{
                print("Premium button tapped")
                Neon.isUserPremium = true
                self.present(destinationVC: LoginVC(viewModel: LoginViewModel()), slideDirection: .right)
            }
           
            
            } else if button == basicButton {
                if(canDismiss){
                    dismiss(animated: true)
                }else{
                    print("Without Premium button tapped")
                    self.present(destinationVC: LoginVC(viewModel: LoginViewModel()), slideDirection: .right)
                }
          
        }
    }
}
