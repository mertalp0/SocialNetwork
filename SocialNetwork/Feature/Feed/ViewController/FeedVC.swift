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
    override func viewWillAppear(_ animated: Bool) {
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
        tableView = FeedTableView(objects: [], heightForRows: 230, style: .grouped, delegate: self)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        tableView.didSelect = { object, indexPath in
            print("Selected: \(object.username) at row \(indexPath.row)")
        }
    }
    
    @objc private func handleRefresh() {
        fetchPostsAndUpdateTableView()
    }
    
    private func fetchPostsAndUpdateTableView() {
        viewModel.fetchPosts { [weak self] in
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
        if (Neon.isUserPremium) {
            let viewModel = PostCreateViewModel()
            let postCreateVC = PostCreateVC(viewModel: viewModel)
            present(destinationVC: postCreateVC, slideDirection: .up)
        }
        else {
            let viewModel = PaywallViewModel()
            let paywallCV = PaywallVC(viewModel: viewModel)
            paywallCV.canDismiss = true
            present(destinationVC: paywallCV, slideDirection: .up)
        }
    }
}

// MARK: - FeedCellDelegate
extension FeedVC: FeedCellDelegate {
    
    func onTapLike(for post: Post) {
        print("Like tapped for post: \(post)")
    }
    
    func onTapComment(for post: Post) {
        print("Comment tapped for post: \(post)")
        
        let commentViewModel = CommentViewModel(post: post)
        let commentVC = CommentVC(viewModel: commentViewModel)
        present(destinationVC: commentVC, slideDirection: .right)
    }
}
