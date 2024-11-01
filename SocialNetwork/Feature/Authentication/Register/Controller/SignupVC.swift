//
//  SignupVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

class SignUpVC: BaseVC<SignupViewModel> {
    
    private var signUpTitle: UILabel!
    private var profileImageContainerView: UIView!
    private var profileImageView: UIImageView!
    private var usernameTextField: CustomTextField!
    private var nicknameTextField: CustomTextField!
    private var mailTextField: CustomTextField!
    private var passwordTextField: CustomTextField!
    private var aboutMeTextField: CustomTextField!
    private var orLabel: UILabel!
    private var googleButton: SocialIconButton!
    private var appleButton: SocialIconButton!
    private var alreadyHaveAccountLabel: UILabel!
    private var loginButton: UILabel!
    private var signUpButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Başlık
        signUpTitle = UILabel()
        signUpTitle.text = "Sign up"
        signUpTitle.font = UIFont.dynamicFont(size: 20, weight: .bold)
        view.addSubview(signUpTitle)
        signUpTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        // Container view oluşturuyoruz
        profileImageContainerView = UIView()
        profileImageContainerView.backgroundColor = .transparentGray
        profileImageContainerView.layer.cornerRadius = .cornerRadius
        profileImageContainerView.layer.masksToBounds = true
        
        let onTapProfileView = UITapGestureRecognizer(target: self, action: #selector(onTapProfileView))
        profileImageContainerView.addGestureRecognizer(onTapProfileView)

        view.addSubview(profileImageContainerView)
        profileImageContainerView.snp.makeConstraints { make in
            make.top.equalTo(signUpTitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }

        // Profil Resmi
        profileImageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill.badge.plus"))
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .lightGray
        profileImageContainerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        // Kullanıcı Adı Alanı
        usernameTextField = CustomTextField(placeholder: "Username")
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        // Nickname Alanı
        nicknameTextField = CustomTextField(placeholder: "Nickname")
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(40)
        }
        
        // Mail Alanı
        mailTextField = CustomTextField(placeholder: "Mail")
        view.addSubview(mailTextField)
        mailTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(40)
        }
        
        // Şifre Alanı
        passwordTextField = CustomTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .none
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(40)
        }
        
        // Hakkımda Alanı
        aboutMeTextField = CustomTextField(placeholder: "About Me")
        view.addSubview(aboutMeTextField)
        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(usernameTextField)
            make.height.equalTo(40)
        }
        
        // "or" Etiketi
        orLabel = UILabel()
        orLabel.text = "or"
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(orLabel)
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // Google Butonu
        googleButton = SocialIconButton(type: .google)
        googleButton.delegate = self

        view.addSubview(googleButton)
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.width.height.equalTo(40)
        }
        
        // Apple Butonu
        appleButton = SocialIconButton(type: .apple)
        appleButton.delegate = self
        view.addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.width.height.equalTo(40)
        }
        
        // Hesabınız var mı? Etiketi
        alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = "Already have an account?"
        alreadyHaveAccountLabel.textColor = .gray
        alreadyHaveAccountLabel.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(alreadyHaveAccountLabel)
        alreadyHaveAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // Login Butonu
        loginButton = UILabel()
        loginButton.text = "login"
        loginButton.textColor = .primaryColor
        loginButton.font = UIFont.dynamicFont(size: 14)
        loginButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginButton.addGestureRecognizer(tapGesture)
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(alreadyHaveAccountLabel.snp.bottom)
            make.centerX.equalTo(alreadyHaveAccountLabel.snp.centerX)
        }
        
        // Sign Up Butonu
        signUpButton = CustomButton(
            title: "Sign up",
            backgroundColor: .transparentGray,
            type: .medium,
            textColor: .textColor
        )
        view.addSubview(signUpButton)
        signUpButton.delegate = self
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onTapProfileView(){
        profileImageContainerView.animateButtonPress {
               print("Profile view tapped!")
           }
    }
}


extension SignUpVC: CustomButtonDelegate {
    
    func customButtonDidTap(_ button: CustomButton) {
    
              viewModel.username = usernameTextField.text ?? ""
              viewModel.nickname = nicknameTextField.text ?? ""
              viewModel.email = mailTextField.text ?? ""
              viewModel.password = passwordTextField.text ?? ""
              viewModel.aboutMe = aboutMeTextField.text ?? ""
              
              viewModel.signUp()
    }
}

extension SignUpVC: SocialIconButtonDelegate {
    
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
