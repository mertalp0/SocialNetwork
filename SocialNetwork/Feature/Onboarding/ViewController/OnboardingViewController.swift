//
//  OnboardingViewController.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//
// OnboardingViewController.swift
// SocialNetwork

import UIKit
import NeonSDK

protocol OnboardingPageDelegate: AnyObject {
    func didTapContinueButton(on page: UIViewController)
}

final class OnboardingViewController: UIViewController {
    
    private var pageViewController: UIPageViewController!
    
    private lazy var pages: [UIViewController] = {
        
        let firstPage = FirstPageViewController()
        firstPage.delegate = self
        
        let secondPage = SecondPageViewController()
        secondPage.delegate = self
        
        return [firstPage, secondPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}

extension OnboardingViewController: OnboardingPageDelegate {
    func didTapContinueButton(on page: UIViewController) {
        guard let currentIndex = pages.firstIndex(of: page) else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < pages.count {
            pageViewController.setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
        } else {
            
            Neon.onboardingCompleted()
            
            let loginViewModel = LoginViewModel()
            let loginVC = LoginVC(viewModel: loginViewModel)
            present(destinationVC: loginVC, slideDirection: .right)
       
        }
    }
}