//
//  LoginVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

class LoginVC: BaseVC<LoginViewModel> {
    
    private var loginTitle: UILabel!
    private var emailTextField: CustomTextField!
    private var passwordTextField: CustomTextField!
    private var forgotPasswordButton: UIButton!
    private var googleButton: SocialIconButton!
    private var appleButton: SocialIconButton!
    private var orLabel: UILabel!
    private var signUpTextLabel: UILabel!
    private var signUpButton: UILabel!
    private var loginButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        loginTitle = UILabel()
        loginTitle.text = "Login"
        loginTitle.font = UIFont.dynamicFont(size: 20, weight: .bold)
        view.addSubview(loginTitle)
        loginTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        emailTextField = CustomTextField(placeholder: "Mail")
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTitle.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        passwordTextField = CustomTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(40)
        }
        
        // Forgot Password Button
        forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.gray, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.trailing.equalTo(passwordTextField)
        }
        
        // "or" Label
        orLabel = UILabel()
        orLabel.text = "or"
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(orLabel)
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // Google Login Button
        googleButton = SocialIconButton(type: .google)
        googleButton.delegate = self
        view.addSubview(googleButton)
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.width.height.equalTo(40)
        }
        
        // Apple Login Button
        appleButton = SocialIconButton(type: .apple)
        appleButton.delegate = self
        view.addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.width.height.equalTo(40)
        }
        
        // Sign Up Text Label
        signUpTextLabel = UILabel()
        signUpTextLabel.text = "Don't have an account yet?"
        signUpTextLabel.textColor = .gray
        signUpTextLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(signUpTextLabel)
        
        signUpTextLabel.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // Sign Up Button Label
        signUpButton = UILabel()
        signUpButton.text = "sign up"
        signUpButton.textColor = .primaryColor
        signUpButton.font = UIFont.dynamicFont(size: 14)
        signUpButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        signUpButton.addGestureRecognizer(tapGesture)
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signUpTextLabel.snp.top).offset(25)
            make.centerX.equalTo(signUpTextLabel)
        }
        
        // Login Button
        loginButton = CustomButton(
            title: "Continue",
            backgroundColor: .transparentGray,
            type: .medium,
            textColor: .textColor
        )
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func signUpTapped() {
        let signupViewModel = SignupViewModel()
        let signUpVC = SignUpVC(viewModel: signupViewModel)
        present(destinationVC: signUpVC, slideDirection: .right)
    }
}

extension LoginVC: CustomButtonDelegate {
    
    func customButtonDidTap(_ button: CustomButton) {
        print("Login button tapped!")
        
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        
        
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true)
        
//        viewModel.login { result in
//            switch result {
//            case .success(_):
//                print("success")
//                
//                burdaya
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

extension LoginVC: SocialIconButtonDelegate {
    func socialIconButtonDidTap(_ button: SocialIconButton) {
        switch button{
        case googleButton:
            print("google button tapped")
            
        case appleButton:
            print("apple button tapped")
            
        default:
            print("unknown button tapped")
        }
    }
}
