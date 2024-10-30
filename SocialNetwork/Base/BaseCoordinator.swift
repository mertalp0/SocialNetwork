//
//  BaseCoordinator.swift
//  SocialNetwork
//
//  Created by mert alp on 30.10.2024.
//
//
//import UIKit
//
//protocol BaseCoordinatorProtocol {
//    var navigationController: UINavigationController? {get set}
//    func start()
//    func back()
//    func popToController(ofType type: UIViewController.Type)
//    func popToRoot()
//}
//
//class BaseCoordinator : BaseCoordinatorProtocol {
//    
//    var navigationController: UINavigationController?
//    
//    init(navigationController: UINavigationController?) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        //Start method should be implemented in subclass
//    }
//    
//    func back() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    func popToController(ofType type: UIViewController.Type) {
//        guard let viewController = navigationController?.viewControllers.first(where: { $0.isKind(of: type) }) else {
//            return
//        }
//        navigationController?.popToViewController(viewController, animated: true)
//    }
//    
//    func popToRoot() {
//        navigationController?.popToRootViewController(animated: true)
//    }
//
//}
