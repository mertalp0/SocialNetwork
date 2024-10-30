//
//  SignupVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//


import UIKit
import SnapKit

class SignupVC: UIViewController {

    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let nicknameTextField = CustomTextField(placeholder: "Nickname")
    private let emailTextField = CustomTextField(placeholder: "Mail")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let aboutMeTextField = CustomTextField(placeholder: "About Me")
    private let signupButton = CustomButton(title: "Sign up")
    private let googleButton = SocialIconButton(imageName: "google_icon")
    private let appleButton = SocialIconButton(imageName: "apple_icon")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Sign up"
        
        view.addSubview(usernameTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(aboutMeTextField)
        view.addSubview(signupButton)
        view.addSubview(googleButton)
        view.addSubview(appleButton)

        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        signupButton.snp.makeConstraints { make in
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }

        googleButton.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(60)
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-60)
        }
    }
}