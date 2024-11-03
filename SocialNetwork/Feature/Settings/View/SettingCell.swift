//
//  SettingCell.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class SettingCell: NeonTableViewCell<SettingOption> {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Icon ImageView
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemGreen
        contentView.addSubview(iconImageView)
        
        // Title Label
        titleLabel.font = .systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        
        // SnapKit Constraints
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
    
    override func configure(with option: SettingOption) {
        iconImageView.image = option.icon
        titleLabel.text = option.title
        titleLabel.textColor = option.titleColor
    }
}
