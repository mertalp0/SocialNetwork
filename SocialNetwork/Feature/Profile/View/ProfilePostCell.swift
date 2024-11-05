//
//  ProfilePostCell.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit
import NeonSDK
import Kingfisher

final class ProfilePostCell: NeonTableViewCell<Post> {
    
    // MARK: - UI Elements
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
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupSubviews() {
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 4
        contentStackView.alignment = .leading
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 16)
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .gray
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel])
        nameStackView.axis = .horizontal
        nameStackView.spacing = 4
        contentStackView.addArrangedSubview(nameStackView)
        
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentStackView.addArrangedSubview(contentLabel)
        
        postImageView.layer.cornerRadius = 10
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        contentStackView.addArrangedSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.height.equalTo(200).priority(.low)
        }
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeCountLabel.font = .systemFont(ofSize: 14)
        
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.tintColor = .black
        commentCountLabel.font = .systemFont(ofSize: 14)
        
        let actionsStackView = UIStackView(arrangedSubviews: [likeButton, likeCountLabel, commentButton, commentCountLabel])
        actionsStackView.axis = .horizontal
        actionsStackView.spacing = 16
        contentStackView.addArrangedSubview(actionsStackView)
    }
    
    // MARK: - Configure Cell
    override func configure(with post: Post) {
        if let profileImageUrl = URL(string: post.userImageUrl) {
            profileImageView.kf.setImage(with: profileImageUrl)
        } else {
            profileImageView.image = UIImage(named: "defaultProfile")
        }
        
        nameLabel.text = post.username
        usernameLabel.text = "@\(post.userNickname)"
        contentLabel.text = post.text
        
        if let postImageUrl = post.imageUrl, let url = URL(string: postImageUrl) {
            postImageView.kf.setImage(with: url)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        likeCountLabel.text = "\(post.likers.count)"
        commentCountLabel.text = "\(post.commenters.count)"
    }
}
