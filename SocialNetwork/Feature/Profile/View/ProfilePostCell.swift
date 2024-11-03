//
//  ProfilePostCell.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class ProfilePostCell: NeonTableViewCell<PostModel> {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let contentLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeButton = UIButton()
    private let commentButton = UIButton()
    private let likeCountLabel = UILabel()
    private let commentCountLabel = UILabel()
    
    private let contentStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Profil Resmi (Sol Sütun)
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        
        // İçerik Yığını (Sağ Sütun)
        contentStackView.axis = .vertical
        contentStackView.spacing = 4
        contentStackView.alignment = .leading
        contentView.addSubview(contentStackView)
        
        // Kullanıcı Adı (Name)
        nameLabel.font = .boldSystemFont(ofSize: 16)
        
        // Kullanıcı İsmi (Username)
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .gray
        
        // Kullanıcı Adı ve İsmi Stack
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel])
        nameStackView.axis = .horizontal
        nameStackView.spacing = 4
        contentStackView.addArrangedSubview(nameStackView)
        
        // İçerik
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(contentLabel)
        
        // Post Resmi (Opsiyonel)
        postImageView.layer.cornerRadius = 10
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        contentStackView.addArrangedSubview(postImageView)
        
        // Beğeni ve Yorum Butonları
        let actionsStackView = UIStackView(arrangedSubviews: [likeButton, likeCountLabel, commentButton, commentCountLabel])
        actionsStackView.axis = .horizontal
        actionsStackView.spacing = 16
        contentStackView.addArrangedSubview(actionsStackView)
        
        // Beğeni Butonu ve Sayısı
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeCountLabel.font = .systemFont(ofSize: 14)
        
        // Yorum Butonu ve Sayısı
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.tintColor = .black
        commentCountLabel.font = .systemFont(ofSize: 14)
        
        // Layout
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        // Post Resmi Yüksekliği (Görünürken)
        postImageView.snp.makeConstraints { make in
            make.height.equalTo(200).priority(.low) // Görünür olduğunda yüksekliği 200 olacak
        }
    }
    
    override func configure(with post: PostModel) {
        profileImageView.image = UIImage(named: post.profileImageName ?? "Mert")
        nameLabel.text = post.username // Kullanıcı adı (örneğin, tam isim)
        usernameLabel.text = post.handle // Kullanıcı ismi (örneğin, @kullaniciAdi)
        contentLabel.text = post.content
        
        // Gönderi resmi opsiyonel
        if let postImageName = post.postImageName {
            postImageView.image = UIImage(named: postImageName)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        likeCountLabel.text = "\(post.likeCount)"
        commentCountLabel.text = "\(post.commentCount)"
    }
}
