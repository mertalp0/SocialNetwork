//
//  CommentCell.swift
//  SocialNetwork
//
//  Created by mert alp on 5.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class CommentCell: UITableViewCell {
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let timeLabel = UILabel()
    private let commentTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        
        usernameLabel.font = .boldSystemFont(ofSize: 14)
        contentView.addSubview(usernameLabel)
        
        nicknameLabel.font = .systemFont(ofSize: 12)
        nicknameLabel.textColor = .gray
        contentView.addSubview(nicknameLabel)
        
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = .lightGray
        contentView.addSubview(timeLabel)
        
        commentTextLabel.font = .systemFont(ofSize: 14)
        commentTextLabel.numberOfLines = 0
        contentView.addSubview(commentTextLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(2)
            make.left.equalTo(usernameLabel)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with comment: Comment) {
        if let url = URL(string: comment.userImageUrl) {
            profileImageView.kf.setImage(with: url)
        }
        usernameLabel.text = comment.username
        nicknameLabel.text = "@\(comment.nickname)"
        timeLabel.text = DateFormatter.localizedString(from: comment.createdAt, dateStyle: .short, timeStyle: .short)
        commentTextLabel.text = comment.commentText
    }
}
