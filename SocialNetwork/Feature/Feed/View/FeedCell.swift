//
//  FeedCell.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import SnapKit
import Kingfisher
import NeonSDK

// FeedCell.swift
protocol FeedCellDelegate: AnyObject {
    func onTapLike(for post: Post)
    func onTapComment(for post: Post)
}

final class FeedCell: NeonTableViewCell<Post> {
    
    static let reuseIdentifier = "FeedCell"
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let contentLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeButton = UIButton()
    private let commentButton = UIButton()
    private let likeCountLabel = UILabel()
    private let commentCountLabel = UILabel()
    private let separatorView = UIView()
    
    weak var delegate: FeedCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(usernameLabel)
        
        nickNameLabel.font = .systemFont(ofSize: 14)
        nickNameLabel.textColor = .gray
        contentView.addSubview(nickNameLabel)
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        
        contentLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        postImageView.layer.cornerRadius = 10
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        contentView.addSubview(postImageView)
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector (didTapLike), for: .touchUpInside)
        contentView.addSubview(likeButton)
        
        likeCountLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(likeCountLabel)
        
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.tintColor = .black
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        contentView.addSubview(commentButton)
        
        commentCountLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(commentCountLabel)
        
        separatorView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        contentView.addSubview(separatorView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(2)
            make.left.equalTo(usernameLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeButton.snp.right).offset(4)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeCountLabel.snp.right).offset(16)
            make.width.height.equalTo(24)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentButton)
            make.left.equalTo(commentButton.snp.right).offset(4)
        }
        
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configure(with post: Post) {
        if let url = URL(string: post.userImageUrl) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultProfile"))
        }
        
        usernameLabel.text = post.username
        nickNameLabel.text = "@\(post.userNickname)"
        dateLabel.text = DateFormatter.localizedString(from: post.createdAt, dateStyle: .medium, timeStyle: .none)
        contentLabel.text = post.text
        
        if let imageUrl = post.imageUrl, let url = URL(string: imageUrl) {
            postImageView.kf.setImage(with: url)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        likeCountLabel.text = "\(post.likers.count)"
        commentCountLabel.text = "\(post.commenters.count)"
    }
}

//MARK: - Action
extension FeedCell {
    @objc func didTapLike() {
        delegate?.onTapLike()
    }
    
    @objc func didTapComment() {
        delegate?.onTapComment()
    }

}
