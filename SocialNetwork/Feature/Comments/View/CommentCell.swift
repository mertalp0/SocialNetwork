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
    
    private let usernameLabel = UILabel()
    private let commentTextLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(commentTextLabel)
        contentView.addSubview(dateLabel)
        
        usernameLabel.font = .boldSystemFont(ofSize: 14)
        commentTextLabel.font = .systemFont(ofSize: 14)
        commentTextLabel.numberOfLines = 0
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        usernameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
        }
        
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commentTextLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with comment: Comment) {
        usernameLabel.text = comment.username
        commentTextLabel.text = comment.commentText
        dateLabel.text = DateFormatter.localizedString(from: comment.createdAt, dateStyle: .short, timeStyle: .short)
    }
}

