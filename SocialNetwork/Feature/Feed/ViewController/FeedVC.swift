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
    private var tableView: NeonTableView<Post, FeedCell>!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        setupTableView()
        setupCreateButton()
        
        fetchPostsAndUpdateTableView()
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
        tableView = NeonTableView<Post, FeedCell>(objects: [], heightForRows: 350)
        
        // Refresh Control ayarları
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
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
    
    @objc private func handleRefresh() {
        fetchPostsAndUpdateTableView()
    }
    
    private func fetchPostsAndUpdateTableView() {
        viewModel.fetchPosts { [weak self] in
            // `fetchPosts` tamamlandıktan sonra tabloyu güncelle
            self?.tableView.objects = self?.viewModel.posts ?? []
            self?.refreshControl.endRefreshing()
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
