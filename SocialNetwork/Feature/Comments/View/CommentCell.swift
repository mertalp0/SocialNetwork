//
//  CommentCell.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class CommentCell: UITableViewCell {
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let dateLabel = UILabel()
    private let commentTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
    
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
   
        usernameLabel.font = .boldSystemFont(ofSize: 14)
        
        nicknameLabel.font = .systemFont(ofSize: 14)
        nicknameLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        commentTextLabel.font = .systemFont(ofSize: 14)
        commentTextLabel.numberOfLines = 0
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentTextLabel)
        
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(usernameLabel)
            make.left.equalTo(usernameLabel.snp.right).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(usernameLabel)
            make.left.equalTo(nicknameLabel.snp.right).offset(10)
        }
        
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with comment: Comment) {
        if let url = URL(string: comment.userImageUrl) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "Mert")
        }
        
        usernameLabel.text = comment.username
        nicknameLabel.text = "@\(comment.nickname)"
        dateLabel.text = DateFormatter.localizedString(from: comment.createdAt, dateStyle: .short, timeStyle: .none)
        commentTextLabel.text = comment.commentText
    }
}
