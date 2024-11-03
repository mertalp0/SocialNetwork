//
//  MainTabBarController.swift
//  SocialNetwork
//
//  Created by mert alp on 1.11.2024.
//
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarAppearance()
    }
    
    private func setupTabBar() {
        // Feed sayfası
        let feedViewModel = FeedViewModel()
        let feedVC = FeedVC(viewModel: feedViewModel)
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        // Network sayfası
        let networkViewModel = NetworkViewModel()
        let networkVC = NetworkVC(viewModel: networkViewModel)
        networkVC.tabBarItem = UITabBarItem(title: "Network", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))
        
        // Profile sayfası
        let profileViewModel = ProfileViewModel()
        let profileVC = ProfileVC(viewModel: profileViewModel)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        // Tab bar view controller'larını ekliyoruz
        viewControllers = [feedVC, networkVC, profileVC]
    }


    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        let customGrayColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0) // Özel açık gri ton
        appearance.backgroundColor = customGrayColor // Arka plan özel açık gri
        
        // Normal durumdaki öğe renkleri (ikon ve yazı)
        let iconAndTextGray = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // İkonlar için daha koyu gri
        appearance.stackedLayoutAppearance.normal.iconColor = iconAndTextGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: iconAndTextGray]
        
        // Seçili durumdaki öğe renkleri (ikon ve yazı)
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        // Tab bar görünümünü ayarlıyoruz
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
