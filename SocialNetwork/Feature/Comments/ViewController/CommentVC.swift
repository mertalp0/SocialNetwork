//
//  CommentVC.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import UIKit
import NeonSDK

final class CommentVC: BaseVC<CommentViewModel> {
    
    private let appBar = SettingsAppBar(title: "Comment")
    private var sendButton: CustomButton!
    
    private var user: AppUser? {
        return UserManager.shared.currentUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTextField()
        setupTableView()
        setupSendButton()
    
    }
    
    private func setupUI() {
        
        view.addSubview(appBar)
        appBar.delegate = self
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupSendButton() {
        
        sendButton = CustomButton(title: "Send", backgroundColor: .primaryColor, type: .large, textColor: .white)
        sendButton.delegate = self
        
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTextField(){}
    
    private func setupTableView() {}

}


// MARK: - SettingsAppBarDelegate
extension CommentVC: SettingsAppBarDelegate {
    func didTapBackButton() {
        self.dismiss(animated: true)
    }
}

//MARK: - CustomButtonDelegate
extension CommentVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        print("send comment")
        viewModel.pushComment(text: "first commit") { success in
            print("dgv")
        }
    }
    
    
}
