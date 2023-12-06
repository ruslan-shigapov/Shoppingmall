//
//  TabBarCoordinator.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 20.11.2023.
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
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
