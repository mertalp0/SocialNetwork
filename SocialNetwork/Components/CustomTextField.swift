//
//  CustomTextField.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

// MARK: - CustomTextField
class CustomTextField: UITextField {
    
    // MARK: - Initializers
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup TextField
    private func setupTextField() {
        borderStyle = .none
        font = UIFont.dynamicFont(size: 14)
        textColor = .black
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .lightGray
        addSubview(bottomBorder)
        
        bottomBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
