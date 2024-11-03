//
//  FeedCell.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class FeedCell: NeonTableViewCell<PostModel> {
    
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let handleLabel = UILabel()
    private let dateLabel = UILabel()
    private let contentLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeButton = UIButton()
    private let commentButton = UIButton()
    private let likeCountLabel = UILabel()
    private let commentCountLabel = UILabel()
    private let separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Profil Resmi
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(named: "Mert") // Varsayılan profil resmi
        contentView.addSubview(profileImageView)
        
        // Kullanıcı Adı
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(usernameLabel)
        
        // Kullanıcı Handle'ı
        handleLabel.font = .systemFont(ofSize: 14)
        handleLabel.textColor = .gray
        contentView.addSubview(handleLabel)
        
        // Tarih
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        
        // İçerik
        contentLabel.font = UIFont.dynamicFont(size: 13,weight: .semibold)
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        // Post Resmi (Opsiyonel)
        postImageView.layer.cornerRadius = .cornerRadius
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        contentView.addSubview(postImageView)
        
        // Beğeni Butonu ve Sayısı
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        contentView.addSubview(likeButton)
        
        likeCountLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(likeCountLabel)
        
        // Yorum Butonu ve Sayısı
        commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        commentButton.tintColor = .black
        contentView.addSubview(commentButton)
        
        commentCountLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(commentCountLabel)
        
        // Çizgi görünümünü ayarlayın
        separatorView.backgroundColor = .transparentGray
        contentView.addSubview(separatorView)
        
        // SnapKit ile yerleşim
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        handleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(2)
            make.left.equalTo(usernameLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        // İçerik Resmi (postImageView) ve İçerik Metni (contentLabel)
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(handleLabel.snp.bottom).offset(12)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(handleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(postImageView.snp.left).offset(-8) // Sağdaki resimle arasında boşluk bırak
            make.bottom.lessThanOrEqualTo(postImageView.snp.bottom) // Resim yüksekliğine göre sınırla
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(12)
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
        
        // Ayırıcı çizgi (separatorView) yerleşimi
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16) // Yatay kenarlardan boşluk
            make.bottom.equalToSuperview()
            make.height.equalTo(1) // Çizgi kalınlığı
        }
    }
    
    override func configure(with post: PostModel) {
        // Profil resmini ayarla veya varsayılan resmi kullan
        if let profileImageName = post.profileImageName, let profileImage = UIImage(named: profileImageName) {
            profileImageView.image = profileImage
        } else {
            profileImageView.image = UIImage(named: "defaultProfile") // Varsayılan resim
        }
        
        usernameLabel.text = post.username
        handleLabel.text = post.handle
        dateLabel.text = post.date
        contentLabel.text = post.content
        
        // Gönderi resmini ayarla veya gizle
        if let postImageName = post.postImageName, let postImage = UIImage(named: postImageName) {
            postImageView.image = postImage
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        likeCountLabel.text = "\(post.likeCount)"
        commentCountLabel.text = "\(post.commentCount)"
    }
}
