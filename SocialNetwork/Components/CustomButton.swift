//
//  CustomButton.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import SnapKit

// MARK: - CustomButtonDelegate
protocol CustomButtonDelegate: AnyObject {
    func customButtonDidTap(_ button: CustomButton)
}

// MARK: - CustomButton
class CustomButton: UIButton {
    
    // MARK: - ButtonType Enum
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
    
    // MARK: - Properties
    weak var delegate: CustomButtonDelegate?
    
    // MARK: - Initializers
    init(title: String, backgroundColor: UIColor, type: ButtonType, textColor: UIColor) {
        super.init(frame: .zero)
        
        setupButton(title: title, backgroundColor: backgroundColor, textColor: textColor)
        
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
    
    // MARK: - Setup
    private func setupButton(title: String, backgroundColor: UIColor, textColor: UIColor) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(textColor, for: .normal)
        layer.cornerRadius = .cornerRadius
        clipsToBounds = true
        titleLabel?.font = UIFont.dynamicFont(size: 16, weight: .bold)
    }
}

// MARK: - Actions
private extension CustomButton {
    
    @objc func buttonTapped() {
        animateButtonPress {
            self.delegate?.customButtonDidTap(self)
        }
    }
}
