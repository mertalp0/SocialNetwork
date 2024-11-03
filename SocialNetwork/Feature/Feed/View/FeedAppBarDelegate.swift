//
//  FeedAppBarDelegate.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//


import UIKit
import SnapKit


protocol FeedAppBarDelegate: AnyObject {
    func settingsButtonTapped()
}

final class FeedAppBar: UIView {
    
    private var user = UserManager.shared.currentUser
    weak var delegate: FeedAppBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupView() {
        self.backgroundColor = .white
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Mert")
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        // Karşılama metni
        let greetingLabel = UILabel()
        greetingLabel.text = user?.username
        greetingLabel.font = UIFont.dynamicFont(size: 18,weight: .bold)
        addSubview(greetingLabel)
        greetingLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        // Ayarlar butonu
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.tintColor = .gray
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    @objc private func settingsTapped() {
        delegate?.settingsButtonTapped()
    }
}
