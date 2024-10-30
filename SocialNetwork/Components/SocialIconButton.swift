//
//  SocialIconButton.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//


import UIKit

class SocialIconButton: UIButton {

    init(imageName: String) {
        super.init(frame: .zero)
        let icon = UIImage(named: imageName)
        self.setImage(icon, for: .normal)
        setupIconButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupIconButton() {
        self.backgroundColor = .clear
        self.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }
}