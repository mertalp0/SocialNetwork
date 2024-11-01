//
//  SecondPageViewController.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import SnapKit

final class SecondPageViewController: UIViewController {
    
    weak var delegate: OnboardingPageDelegate?
    
    private var titleLabel1 : UILabel!
    private var titleLabel2 :  UILabel!
    private var titleLabel3 : UILabel!
    private var titleLabel4 :  UILabel!
    private var titleLabel5 : UILabel!
    
    private var bodyLabel1 : UILabel!
    private var bodyLabel2 : UILabel!
    
    
    private var continueButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        // üçüncü Başlık (Yeşil renk)
        titleLabel3 = UILabel()
        titleLabel3.text = "Social; netwrok,"
        titleLabel3.font = UIFont.dynamicFont(size: 28 , weight: .bold)
        titleLabel3.textColor = .textColor
        titleLabel3.numberOfLines = 0
        view.addSubview(titleLabel3)
        
        titleLabel3.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
        // İkinci Başlık
        titleLabel2 = UILabel()
        titleLabel2.text = "Purpseful all-in-1"
        titleLabel2.font = UIFont.dynamicFont(size: 28 , weight: .bold)
        titleLabel2.textColor = .primaryColor
        titleLabel2.numberOfLines = 0
        view.addSubview(titleLabel2)
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel3.snp.top).offset(-45)
            make.centerX.equalToSuperview()
        }
        
        
        // İlk Başlık
        titleLabel1 = UILabel()
        titleLabel1.text = "The"
        titleLabel1.font = UIFont.dynamicFont(size: 28 , weight: .bold)
        titleLabel1.textColor = .textColor
        titleLabel1.numberOfLines = 0
        view.addSubview(titleLabel1)
        
        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.top).offset(-45)
            make.centerX.equalToSuperview()
        }
        
       
      
        
        // İkinci Başlık
        titleLabel4 = UILabel()
        titleLabel4.text = "publish, discuss,"
        titleLabel4.font = UIFont.dynamicFont(size: 28 , weight: .bold)
        titleLabel4.textColor = .textColor
        titleLabel4.numberOfLines = 0
        view.addSubview(titleLabel4)
        
        titleLabel4.snp.makeConstraints { make in
            make.top.equalTo(titleLabel3.snp.top).offset(45)
            make.centerX.equalToSuperview()
        }
        
        titleLabel5 = UILabel()
        titleLabel5.text = "impact"
        titleLabel5.font = UIFont.dynamicFont(size: 28 , weight: .bold)
        titleLabel5.textColor = .textColor
        titleLabel5.numberOfLines = 0
        view.addSubview(titleLabel5)
        
        titleLabel5.snp.makeConstraints { make in
            make.top.equalTo(titleLabel4.snp.top).offset(45)
            make.centerX.equalToSuperview()
        }
        
        
       
        // body (Yeşil renk)
        bodyLabel1 = UILabel()
        bodyLabel1.text = "Explore Sustainable Practises"
        bodyLabel1.font = UIFont.dynamicFont(size: 16 , weight: .bold)
        bodyLabel1.textAlignment = .left
        bodyLabel1.textColor = .gray
        bodyLabel1.numberOfLines = 0
        view.addSubview(bodyLabel1)
        
        bodyLabel1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalToSuperview().inset(40)
        }
        
        // body (Yeşil renk)
        bodyLabel2 = UILabel()
        bodyLabel2.text = "and Inspiring Stories"
        bodyLabel2.font = UIFont.dynamicFont(size: 16 , weight: .bold)
        bodyLabel2.textAlignment = .left
        bodyLabel2.textColor = .gray
        bodyLabel2.numberOfLines = 0
        view.addSubview(bodyLabel2)
        
        bodyLabel2.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel1.snp.bottom)
            make.leading.equalToSuperview().inset(40)
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

extension SecondPageViewController: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        delegate?.didTapContinueButton(on: self)
    }
}
