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
    private var tableView: NeonTableView<PostModel, ProfilePostCell>!
    private let profileHeaderView = ProfileHeaderView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        setupHeaderView()
        setupTableView()
    }
    
    private func setupAppBar() {
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupHeaderView(){
        view.addSubview(profileHeaderView)
        
        profileHeaderView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        let posts = [
            PostModel(profileImageName: "Mert", username: "Sophie", handle: "@shopie.Joll", date: "Nov 2, 2024", content: "Lorem ipsskjfkjsdhfjkshdjfhdsjlkjhgjkfdjslkdfj klsdjflksdjlkfjdhsjfghdjkhgum dolor sit amet...", postImageName: "Mert", likeCount: 1100, commentCount: 123),
            PostModel(profileImageName: "Mert", username: "Sophie", handle: "@shopie.Joll", date: "Nov 2, 2024", content: "Lorem ipsum dolor sit amet...", postImageName: "Mert", likeCount: 900, commentCount: 200)
        ]
        
        tableView = NeonTableView<PostModel, ProfilePostCell>(objects: posts, heightForRows: 350)
     // tableView.tableHeaderView = profileHeaderView
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
