//
//  CustomAppBar.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit

protocol CustomAppBarDelegate: AnyObject {
    func didTapBackButton()
    func didTapCancelButton()
}

final class CustomAppBar: UIView {
    
    weak var delegate: CustomAppBarDelegate?
    
    private let backButton = UIButton()
    private let cancelButton = UIButton()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        // Geri Butonu
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        addSubview(backButton)
        
        // Başlık
        titleLabel.text = "New Post"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        // İptal Butonu
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        addSubview(cancelButton)
        
        // SnapKit ile yerleşim
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func didTapBack() {
        delegate?.didTapBackButton()
    }
    
    @objc private func didTapCancel() {
        delegate?.didTapCancelButton()
    }
}
