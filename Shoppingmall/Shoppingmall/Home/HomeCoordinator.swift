//
//  HomeCoordinator.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 30.01.2024.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    private let navigationController = UINavigationController()
    
    override func start() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}
