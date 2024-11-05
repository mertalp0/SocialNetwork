//
//  SocialIconButton.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit

// MARK: - SocialIconButtonDelegate
protocol SocialIconButtonDelegate: AnyObject {
    func socialIconButtonDidTap(_ button: SocialIconButton)
}

// MARK: - SocialIconButton
class SocialIconButton: UIView {
    
    // MARK: - IconType Enum
    enum IconType {
        case google
        case apple
        
        var iconImage: UIImage? {
            switch self {
            case .google:
                return ImageManager.shared.getImage(for: .googleIcon)
            case .apple:
                return ImageManager.shared.getImage(for: .appleIcon)
            }
        }
    }
    
    // MARK: - Properties
    private var iconImageView: UIImageView!
    weak var delegate: SocialIconButtonDelegate?
    
    // MARK: - Initializers
    init(type: IconType) {
        super.init(frame: .zero)
        
        // Resmi ImageManager üzerinden al
        iconImageView = UIImageView(image: type.iconImage)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .transparentGray
        layer.cornerRadius = .cornerRadius
        clipsToBounds = true
        
        addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(UIScreen.dynamicWidth(24))
        }
    }
    
    // MARK: - Setup Gesture
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
}

// MARK: - Actions
private extension SocialIconButton {
    @objc func handleTap() {
        animateButtonPress {
            self.delegate?.socialIconButtonDidTap(self)
        }
    }
}
