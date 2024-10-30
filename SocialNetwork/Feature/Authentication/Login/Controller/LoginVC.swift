//
//  LoginVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//


import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    private let emailTextField = CustomTextField(placeholder: "Mail")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let continueButton = CustomButton(title: "Continue")
    private let googleButton = SocialIconButton(imageName: "google_icon")
    private let appleButton = SocialIconButton(imageName: "apple_icon")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Login"
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(continueButton)
        view.addSubview(googleButton)
        view.addSubview(appleButton)

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        continueButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }

        googleButton.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(60)
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-60)
        }
    }
}