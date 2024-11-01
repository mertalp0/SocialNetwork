//
//  UIView+AnimatedButton.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit

extension UIView {
    func animateButtonPress(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1,
                           animations: {
                self.transform = CGAffineTransform.identity
            },
                           completion: { _ in
                completion?()
            })
        })
    }
}
