//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import UIKit
import NeonSDK

final class FeedVC: BaseVC<FeedViewModel> {
    
    private var appBar: FeedAppBar!
    private var createButton: CustomButton!
    private var tableView: NeonTableView<PostModel, FeedCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        setupTableView()
        setupCreateButton()
    }
    
    private func setupAppBar() {
        appBar = FeedAppBar()
        
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        appBar.delegate = self
    }
    
    private func setupCreateButton() {
        createButton = CustomButton(title: "Create Post", backgroundColor: .primaryColor, type: .large, textColor: .white)
        createButton.delegate = self
        
        view.addSubview(createButton)
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        // Örnek veri
        let data = Array(repeating: PostModel(profileImageName: "Mert", username: "Gabriel", handle: "@gabrielJoll", date: "Jun 2, 2022", content: "Washington State University: Organic farming is a double win - more profitable and more sustainable.", postImageName: "Mert", likeCount: 1100, commentCount: 123), count: 20)
        
        // NeonTableView oluşturuyoruz ve FeedCell kullanıyoruz
        tableView = NeonTableView<PostModel, FeedCell>(objects: data, heightForRows: 210)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // Hücre seçildiğinde bir işlem yapma
        tableView.didSelect = { object, indexPath in
            print("Selected: \(object.username) at row \(indexPath.row)")
        }
    }
}

// MARK: - FeedAppBarDelegate
extension FeedVC: FeedAppBarDelegate {
    
    func settingsButtonTapped() {
        print("Settings button tapped")
        let viewModel = SettingsViewModel()
        let settingsVC = SettingsVC(viewModel: viewModel)
        present(destinationVC: settingsVC, slideDirection: .right)
    }
}

// MARK: - CustomButtonDelegate
extension FeedVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        print("Create button tapped")
        let viewModel = PostCreateViewModel()
        let postCreateVC = PostCreateVC(viewModel: viewModel)
        present(destinationVC: postCreateVC, slideDirection: .up)
    }
}
