//
//  ProfileHeaderView.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let bioLabel = UILabel()
    
    private let postsLabel = UILabel()
    private let followersLabel = UILabel()
    private let followingLabel = UILabel()
    
    private let statsStackView = UIStackView()
    private let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Profil Resmi
        profileImageView.image = UIImage(named: "Mert")
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)
        
        // İstatistikler (Gönderiler, Takipçi, Takip)
        postsLabel.text = "43\nPosts"
        postsLabel.numberOfLines = 2
        postsLabel.textAlignment = .center
        postsLabel.font = .boldSystemFont(ofSize: 16)
        
        followersLabel.text = "1,613\nFollowers"
        followersLabel.numberOfLines = 2
        followersLabel.textAlignment = .center
        followersLabel.font = .boldSystemFont(ofSize: 16)
        
        followingLabel.text = "919\nFollowing"
        followingLabel.numberOfLines = 2
        followingLabel.textAlignment = .center
        followingLabel.font = .boldSystemFont(ofSize: 16)
        
        // İstatistikleri StackView'da birleştir
        statsStackView.axis = .horizontal
        statsStackView.alignment = .center
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(postsLabel)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        addSubview(statsStackView)
        
        // Kullanıcı Adı
        usernameLabel.text = "@shopie.Joll"
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .gray
        usernameLabel.textAlignment = .left
        addSubview(usernameLabel)
        
        // Biyografi
        bioLabel.text = "27 year old, interested in economics, dog mom."
        bioLabel.font = .systemFont(ofSize: 14)
        bioLabel.textColor = .darkGray
        bioLabel.numberOfLines = 0
        bioLabel.textAlignment = .left
        addSubview(bioLabel)
        
        separatorView.backgroundColor = .transparentGray
        addSubview(separatorView)
        // Ayırıcı çizgi (separatorView) yerleşimi
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview() // Yatay kenarlardan boşluk
            make.bottom.equalToSuperview()
            make.height.equalTo(1) // Çizgi kalınlığı
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
}
