//
//  AppDelegate.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//

import UIKit
import NeonSDK
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
 ///   var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        
        Neon.configure(
            window: &window,
            onboardingVC: OnboardingViewController(),
            paywallVC: PaywallVC(viewModel: PaywallViewModel()),
            homeVC: LoginVC(viewModel: LoginViewModel())
        )
        
        return true
    }
}
