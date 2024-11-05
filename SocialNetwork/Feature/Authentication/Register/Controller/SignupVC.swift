//
//  SignUpVC.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

class SignUpVC: BaseVC<SignupViewModel> {
    
    // MARK: - UI Components
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
    private var selectedProfileImage: UIImage?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupTitle()
        setupProfileImageView()
        setupTextFields()
        setupSocialButtons()
        setupSignUpButton()
    }
    
    private func setupTitle() {
        signUpTitle = UILabel()
        signUpTitle.text = l10n.signUpTitle()
        signUpTitle.font = UIFont.dynamicFont(size: 20, weight: .bold)
        view.addSubview(signUpTitle)
        
        signUpTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(dynamicHeight(50))
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupProfileImageView() {
        profileImageContainerView = UIView()
        profileImageContainerView.backgroundColor = .transparentGray
        profileImageContainerView.layer.cornerRadius = .cornerRadius
        profileImageContainerView.layer.masksToBounds = true
        view.addSubview(profileImageContainerView)
        
        profileImageView = UIImageView(image: ImageManager.shared.getImage(named: .profilePlaceholder))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.tintColor = .lightGray
        profileImageContainerView.addSubview(profileImageView)
        
        profileImageContainerView.snp.makeConstraints { make in
            make.top.equalTo(signUpTitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(dynamicHeight(100))
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let onTapProfileView = UITapGestureRecognizer(target: self, action: #selector(onTapProfileView))
        profileImageContainerView.addGestureRecognizer(onTapProfileView)
    }
    
    private func setupTextFields() {
        usernameTextField = createTextField(placeholder: l10n.usernamePlaceholder())
        nicknameTextField = createTextField(placeholder: l10n.nicknamePlaceholder())
        mailTextField = createTextField(placeholder: l10n.emailPlaceholder())
        passwordTextField = createTextField(placeholder: l10n.passwordPlaceholder())
        aboutMeTextField = createTextField(placeholder: l10n.aboutMePlaceholder())
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .none
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageContainerView.snp.bottom).offset(dynamicHeight(20))
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(dynamicHeight(10))
        }
        mailTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(dynamicHeight(10))
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(mailTextField.snp.bottom).offset(dynamicHeight(10))
        }
        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(dynamicHeight(10))
        }
    }
    
    private func createTextField(placeholder: String) -> CustomTextField {
        let textField = CustomTextField(placeholder: placeholder)
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(dynamicHeight(40))
        }
        
        return textField
    }
    
    private func setupSocialButtons() {
        orLabel = UILabel()
        orLabel.text = l10n.orText()
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.font = UIFont.dynamicFont(size: 14)
        view.addSubview(orLabel)
        
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        googleButton = SocialIconButton(type: .google)
        googleButton.delegate = self
        view.addSubview(googleButton)
        
        appleButton = SocialIconButton(type: .apple)
        appleButton.delegate = self
        view.addSubview(appleButton)
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.width.height.equalTo(40)
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.width.height.equalTo(40)
        }
    }
    
    private func setupSignUpButton() {
        alreadyHaveAccountLabel = UILabel()
        alreadyHaveAccountLabel.text = l10n.alreadyHaveAccountText()
        alreadyHaveAccountLabel.textColor = .gray
        alreadyHaveAccountLabel.font = UIFont.dynamicFont(size: 14)
        view.addSubview(alreadyHaveAccountLabel)
        
        alreadyHaveAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        loginButton = UILabel()
        loginButton.text = l10n.loginText()
        loginButton.textColor = .primaryColor
        loginButton.font = UIFont.dynamicFont(size: 14)
        loginButton.isUserInteractionEnabled = true
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(alreadyHaveAccountLabel.snp.bottom)
            make.centerX.equalTo(alreadyHaveAccountLabel.snp.centerX)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginButton.addGestureRecognizer(tapGesture)
        
        signUpButton = CustomButton(title: l10n.signUpButtonText(), backgroundColor: .transparentGray, type: .medium, textColor: .textColor)
        signUpButton.delegate = self
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func onTapProfileView() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            selectedProfileImage = selectedImage
        }
    }
}

// MARK: - CustomButtonDelegate
extension SignUpVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        viewModel.username = usernameTextField.text ?? ""
        viewModel.nickname = nicknameTextField.text ?? ""
        viewModel.email = mailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.aboutMe = aboutMeTextField.text ?? ""
        viewModel.selectedImage = selectedProfileImage
        
        viewModel.signUp()
    }
}

// MARK: - SocialIconButtonDelegate
extension SignUpVC: SocialIconButtonDelegate {
    func socialIconButtonDidTap(_ button: SocialIconButton) {
        switch button {
        case googleButton:
            print("Google button tapped")
        case appleButton:
            print("Apple button tapped")
        default:
            print("Unknown button tapped")
        }
    }
}

// MARK: - Login Action
private extension SignUpVC {
    @objc func loginTapped() {
        dismiss(animated: true, completion: nil)
    }
}
