//
//  TabBarCoordinator.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        navigationController.setViewControllers(
            [tabBarController],
            animated: true)
    }
}
