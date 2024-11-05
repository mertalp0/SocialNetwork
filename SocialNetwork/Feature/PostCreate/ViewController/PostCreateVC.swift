//
//  PostCreateVC.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit

final class PostCreateVC: BaseVC<PostCreateViewModel> {
    
    // MARK: - UI Components
    private let appBar = CustomAppBar()
    private let profileImageView = UIImageView()
    private let textField = CustomTextField(placeholder: "What is your wisdom?")
    private let addPhotoButton = UIButton()
    private var shareButton: CustomButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppBar()
        setupSubviews()
    }
    
    // MARK: - Setup App Bar
    private func setupAppBar() {
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Setup Subviews
    private func setupSubviews() {
        
        if let profileImageUrlString = UserManager.shared.currentUser?.profileImageUrl,
           let profileImageUrl = URL(string: profileImageUrlString) {
            profileImageView.kf.setImage(with: profileImageUrl)
        } else {
            profileImageView.image = UIImage(named: "Mert")
        }
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        addPhotoButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addPhotoButton.tintColor = .gray
        addPhotoButton.addTarget(self, action: #selector(didTapAddPhotoButton), for: .touchUpInside)
        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(25)
            make.width.height.equalTo(40)
        }
        
        shareButton = CustomButton(title: "Share", backgroundColor: .primaryColor, type: .small, textColor: .white)
        shareButton.delegate = self
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(25)
        }
    }
    
    // MARK: - Actions
    @objc private func didTapAddPhotoButton() {
        print("Add photo button tapped")
    }
    
    @objc private func didTapShareButton() {
        print("Share button tapped")
    }
}

// MARK: - CustomAppBarDelegate
extension PostCreateVC: CustomAppBarDelegate {
    func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CustomButtonDelegate
extension PostCreateVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        print("on tap share button")
        textField.text = ""
        viewModel.text = self.textField.text ?? ""
        viewModel.image = UIImage(named: "Mert")
        viewModel.createPost()
    }
}
