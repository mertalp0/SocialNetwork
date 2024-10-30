//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//


import UIKit
import SnapKit

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}