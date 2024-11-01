//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

protocol CustomButtonDelegate: AnyObject {
    func customButtonDidTap(_ button: CustomButton)
}

class CustomButton: UIButton {
    
    enum ButtonType {
        case small
        case medium
        case large
        
        var dimensions: (width: CGFloat, height: CGFloat) {
            switch self {
            case .small:
                return (width: UIScreen.dynamicWidth(100), height: UIScreen.dynamicHeight(30))
            case .medium:
                return (width: UIScreen.dynamicWidth(120), height: UIScreen.dynamicHeight(50))
            case .large:
                return (width: UIScreen.dynamicWidth(220), height: UIScreen.dynamicHeight(40))
            }
        }
    }
    
    weak var delegate: CustomButtonDelegate?
    
    init(title: String, backgroundColor: UIColor, type: ButtonType, textColor: UIColor) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = .cornerRadius
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.dynamicFont(size: 16, weight: .bold)
        
        let dimensions = type.dimensions
        
        self.snp.makeConstraints { make in
            make.width.equalTo(dimensions.width)
            make.height.equalTo(dimensions.height)
        }
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        animateButtonPress {
            self.delegate?.customButtonDidTap(self)
        }
    }
}
