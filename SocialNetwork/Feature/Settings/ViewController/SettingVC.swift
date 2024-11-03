//
//  SettingsVC.swift
//  SocialNetwork
//
//  Created by mert alp on 2.11.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class SettingsVC: BaseVC<SettingsViewModel> {
    
    private let appBar = SettingsAppBar(title: "Settings")
    private var tableView: NeonTableView<SettingOption, SettingCell>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppBar()
        setupTableView()
    }

    private func setupAppBar() {
        appBar.delegate = self
        view.addSubview(appBar)
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func setupTableView() {
        let options = [
            SettingOption(icon: UIImage(systemName: "square.and.arrow.up"), title: "Share app", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "star"), title: "Rate us", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "envelope"), title: "Contact us", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "questionmark.circle"), title: "Terms of Use", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "shield"), title: "Privacy policy", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "arrow.clockwise"), title: "Restore Purchase", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "person"), title: "Account Settings", titleColor: .black),
            SettingOption(icon: UIImage(systemName: "rectangle.portrait.and.arrow.right"), title: "Log Out", titleColor: .systemRed)
        ]
        
        tableView = NeonTableView<SettingOption, SettingCell>(objects: options, heightForRows: 50)
        tableView.didSelect = { [weak self] option, _ in
            self?.handleOptionSelection(option)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func handleOptionSelection(_ option: SettingOption) {
        if option.title == "Log Out" {
            // Logout işlemi
            viewModel.logout { [weak self] result in
                switch result {
                case .success:
                    self?.navigateToLoginScreen()
                case .failure(let error):
                 print(error)
                }
            }
        } else {
            print("Selected option: \(option.title)")
        }
    }
    
    private func navigateToLoginScreen() {
        UserManager.shared.clearUser()
        let loginViewModel = LoginViewModel()
        let loginVC = LoginVC(viewModel: loginViewModel)
        present(destinationVC: loginVC, slideDirection: .right)
        // Login ekranına yönlendirme işlemi
      
    }
}

// MARK: - SettingsAppBarDelegate
extension SettingsVC: SettingsAppBarDelegate {
    func didTapBackButton() {
        dismiss(animated: true)
    }
}
