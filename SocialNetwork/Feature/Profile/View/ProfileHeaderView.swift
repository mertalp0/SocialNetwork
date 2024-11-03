//
//  ProfileHeaderView.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class ProfileHeaderView: UIView {
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let bioLabel = UILabel()
    
    private let postsLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    
    private let statsStackView = UIStackView()
    private let separatorView = UIView()
    
    private var user: AppUser? {
        return UserManager.shared.currentUser
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        updateUserData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserUpdate), name: .currentUserDidChange, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleUserUpdate() {
        updateUserData()
    }
    
    private func updateUserData() {
        guard let user = user else { return }
        
        // Profil Resmini Güncelle
        if let profileImageUrl = URL(string: user.profileImageUrl) {
            profileImageView.kf.setImage(with: profileImageUrl)
        } else {
            profileImageView.image = UIImage(named: "defaultProfile")
        }
        
        // Kullanıcı Adı ve Biyografi
        usernameLabel.text = "@\(user.nickname)"
        bioLabel.text = user.aboutMe.isEmpty ? "No bio available." : user.aboutMe
        
        // İstatistikleri Güncelle
        postsLabel.text = "\(user.posts.count)\nPosts"
        followersLabel.text = "\(user.followers.count)\nFollowers"
        followingLabel.text = "\(user.following.count)\nFollowing"
    }
    
    private func setupSubviews() {
        // Profil Resmi
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)
        
        // İstatistikler
        postsLabel.numberOfLines = 2
        postsLabel.textAlignment = .center
        postsLabel.font = .boldSystemFont(ofSize: 16)
        
        followersLabel.numberOfLines = 2
        followersLabel.textAlignment = .center
        followersLabel.font = .boldSystemFont(ofSize: 16)
        
        followingLabel.numberOfLines = 2
        followingLabel.textAlignment = .center
        followingLabel.font = .boldSystemFont(ofSize: 16)
        
        // StackView
        statsStackView.axis = .horizontal
        statsStackView.alignment = .center
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(postsLabel)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        addSubview(statsStackView)
        
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .gray
        usernameLabel.textAlignment = .left
        addSubview(usernameLabel)
        
        bioLabel.font = .systemFont(ofSize: 14)
        bioLabel.textColor = .darkGray
        bioLabel.numberOfLines = 0
        bioLabel.textAlignment = .left
        addSubview(bioLabel)
        
        separatorView.backgroundColor = .transparentGray
        addSubview(separatorView)
        
        // Çizgi
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.left.equalTo(profileImageView)
            make.right.equalToSuperview().inset(16)
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.left.equalTo(profileImageView)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
