//
//  CustomTextField.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//


import UIKit
import SnapKit

class CustomTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        self.borderStyle = .none
        self.font = UIFont.dynamicFont(size: 14)
        self.textColor = .black
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .lightGray
        self.addSubview(bottomBorder)
        
        bottomBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
