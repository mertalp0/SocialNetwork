//
//  ProfileVC.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class ProfileVC: BaseVC<ProfileViewModel> {
    
    private let appBar = ProfileAppBar(title: "My Profile")
    private var tableView: NeonTableView<Post, ProfilePostCell>!
    private let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        setupHeaderView()
        setupTableView()
        fetchUserPosts()
        
        // Yeni bir post oluşturulduğunda veya kullanıcı güncellendiğinde dinlemek için gözlemci ekle
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserUpdate), name: .currentUserDidChange, object: nil)
    }
    
    // Gözlemciyi kaldırmak için `deinit`
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleUserUpdate() {
        fetchUserPosts()
    }
    
    private func setupAppBar() {
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupHeaderView() {
        view.addSubview(profileHeaderView)
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView = NeonTableView<Post, ProfilePostCell>(objects: [], heightForRows: 350)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.didSelect = { post, indexPath in
            print("Selected post by user: \(post.username) at row \(indexPath.row)")
        }
    }
    
    private func fetchUserPosts() {
        // currentUser kontrolü yapıyoruz
        guard let user = UserManager.shared.currentUser else {
            print("No current user found")
            return
        }
        
        viewModel.fetchPostsForUserIds(user: user) { [weak self] in
            // TableView verilerini güncelleme
            self?.tableView.objects = self?.viewModel.posts ?? []
        }
    }
}
