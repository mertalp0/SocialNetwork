//
//  MainTabBarController.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearance()
    }
    
    // MARK: - Setup Tab Bar
    private func setupTabBar() {
        let feedVC = FeedVC(viewModel: FeedViewModel())
        feedVC.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let networkVC = NetworkVC(viewModel: NetworkViewModel())
        networkVC.tabBarItem = UITabBarItem(
            title: "Network",
            image: UIImage(systemName: "person.2"),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        
        let profileVC = ProfileVC(viewModel: ProfileViewModel())
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [feedVC, networkVC, profileVC]
    }

    // MARK: - Setup Tab Bar Appearance
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        let customGrayColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        appearance.backgroundColor = customGrayColor
        
        let iconAndTextGray = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        appearance.stackedLayoutAppearance.normal.iconColor = iconAndTextGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: iconAndTextGray
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
