//
//  SettingsAppBar.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//


import UIKit
import SnapKit

protocol SettingsAppBarDelegate: AnyObject {
    func didTapBackButton()
}

final class SettingsAppBar: UIView {
    
    weak var delegate: SettingsAppBarDelegate?
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    init(title: String) {
        super.init(frame: .zero)
        setupView(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String) {
        backgroundColor = .white
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        addSubview(backButton)
        
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func didTapBack() {
        delegate?.didTapBackButton()
    }
}
