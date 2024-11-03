//
//  ProfileAppBar.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit

final class ProfileAppBar: UIView {
    
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
    
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
