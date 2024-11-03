//
//  PostCreateVC.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit

final class PostCreateVC: BaseVC<PostCreateViewModel> {
    
    private let appBar = CustomAppBar()
    private let profileImageView = UIImageView()
    private let textView = UITextView()
    private let addPhotoButton = UIButton()
    private var shareButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppBar()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupAppBar() {
      
        appBar.delegate = self
        view.addSubview(appBar)
        
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupSubviews() {

        
        // Profil Resmi
        profileImageView.image = UIImage(named: "Mert")
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        view.addSubview(profileImageView)
        
        // Yazı Alanı (UITextView)
        textView.font = .systemFont(ofSize: 16)
        textView.text = "What is your wisdom?"
        textView.textColor = .gray
        view.addSubview(textView)
        
        // Fotoğraf Ekleme Butonu
        addPhotoButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addPhotoButton.tintColor = .gray
        addPhotoButton.addTarget(self, action: #selector(didTapAddPhotoButton), for: .touchUpInside)
        view.addSubview(addPhotoButton)
        
        // Paylaş Butonu
       
        shareButton = CustomButton(title: "Share", backgroundColor: .primaryColor, type: .small, textColor: .white)
        shareButton.delegate = self
        view.addSubview(shareButton)
    }
    
    private func setupConstraints() {
        // Profil Resmi
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        // Yazı Alanı (textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        // Fotoğraf Ekleme Butonu
        addPhotoButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(25)
            make.width.height.equalTo(40)
        }
        
        // Paylaş Butonu
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(25)
        }
    }
    
    // Fotoğraf ekleme butonu için aksiyon
    @objc private func didTapAddPhotoButton() {
        print("Add photo button tapped")
       
    }
  
    @objc private func didTapShareButton() {
        print("Share button tapped")
        
    }
}

// MARK: - CustomAppBarDelegate Methods
extension PostCreateVC : CustomAppBarDelegate {
  
    func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - CustomButtonDelegate
extension PostCreateVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        print("on tap share button")
        
        viewModel.text = self.textView.text
        viewModel.image = UIImage(named: "Mert")
        
        viewModel.createPost()
    }
    
   
}
