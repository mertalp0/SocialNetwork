//
//  FirstPageViewController.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import SnapKit

final class FirstPageViewController: UIViewController {
    
    weak var delegate: OnboardingPageDelegate?
    
    private var titleLabel1 : UILabel!
    private var titleLabel2 :  UILabel!
    private var titleLabel3 : UILabel!
    private var bodyLabel : UILabel!
    private var imageView : UIImageView!
    
    private var continueButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // İlk Başlık
        titleLabel1 = UILabel()
        titleLabel1.text = "A social has"
        titleLabel1.font = UIFont.dynamicFont(size: 32 , weight: .bold)
        titleLabel1.textColor = .textColor
        titleLabel1.numberOfLines = 0
        view.addSubview(titleLabel1)
        
        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(85)
            make.leading.equalToSuperview().inset(40)
        }
        
        
        // İkinci Başlık
        titleLabel2 = UILabel()
        titleLabel2.text = "never been so"
        titleLabel2.font = UIFont.dynamicFont(size: 32 , weight: .bold)
        titleLabel2.textColor = .textColor
        titleLabel2.numberOfLines = 0
        view.addSubview(titleLabel2)
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel1.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(40)
        }
        
        // üçüncü Başlık (Yeşil renk)
        titleLabel3 = UILabel()
        titleLabel3.text = "Sustainable"
        titleLabel3.font = UIFont.dynamicFont(size: 32 , weight: .bold)
        titleLabel3.textColor = .primaryColor
        titleLabel3.numberOfLines = 0
        view.addSubview(titleLabel3)
        
        titleLabel3.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(40)
        }
        
       
        // body (Yeşil renk)
        bodyLabel = UILabel()
        bodyLabel.text = "Share Your Eco-friendly Journey, Follow Sustainable Influencers, and Inspire Others to Make a Difference"
        bodyLabel.font = UIFont.dynamicFont(size: 16 , weight: .bold)
        bodyLabel.textAlignment = .left
        bodyLabel.textColor = .gray
        bodyLabel.numberOfLines = 0
        view.addSubview(bodyLabel)
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel3.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        
        // Görsel
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "google_icon")
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        
        // Continue Butonu
        continueButton = CustomButton(
            title: "Continue",
            backgroundColor: .primaryColor,
            type: .medium,
            textColor: .white
        )
        continueButton.delegate = self
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
    }
}

extension FirstPageViewController: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        delegate?.didTapContinueButton(on: self)
    }
}
