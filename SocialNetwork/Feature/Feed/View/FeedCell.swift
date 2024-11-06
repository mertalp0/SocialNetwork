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

protocol FeedCellDelegate: AnyObject {
    func onTapLike(for post: Post)
    func onTapComment(for post: Post)
}

final class FeedCell: NeonTableViewCell<Post> {
    
    var post: Post?
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
        
        usernameLabel.font = .boldSystemFont(ofSize: 14)
        contentView.addSubview(usernameLabel)
        
        nickNameLabel.font = UIFont.systemFont(ofSize: 12)
        nickNameLabel.textColor = .gray
        contentView.addSubview(nickNameLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        postImageView.layer.cornerRadius = .cornerRadius
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        contentView.addSubview(postImageView)
        
        likeButton.setImage(ImageManager.shared.getImage(named: .heartIcon), for: .normal)
        likeButton.tintColor = .black
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        contentView.addSubview(likeButton)
        
        likeCountLabel.font = .systemFont(ofSize: 12)
        likeCountLabel.textColor = .black
        contentView.addSubview(likeCountLabel)
        
        commentButton.setImage(ImageManager.shared.getImage(named: .commentIcon), for: .normal)
        commentButton.tintColor = .black
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        contentView.addSubview(commentButton)
        
        commentCountLabel.font = UIFont.systemFont(ofSize: 12)
        commentCountLabel.textColor = .black
        contentView.addSubview(commentCountLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
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
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(postImageView.snp.left).offset(-8)
        }
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.right.equalToSuperview().inset(12)
            make.width.height.equalTo(120)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(20)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeButton.snp.right).offset(4)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.left.equalTo(likeCountLabel.snp.right).offset(16)
            make.width.height.equalTo(20)
        }
        
        commentCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentButton)
            make.left.equalTo(commentButton.snp.right).offset(4)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func configure(with post: Post) {
        self.post = post
        
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

// MARK: - Actions
extension FeedCell {
    @objc func didTapLike() {
        guard let post = post else { return }
        delegate?.onTapLike(for: post)
    }
    
    @objc func didTapComment() {
        guard let post = post else { return }
        delegate?.onTapComment(for: post)
    }
}
