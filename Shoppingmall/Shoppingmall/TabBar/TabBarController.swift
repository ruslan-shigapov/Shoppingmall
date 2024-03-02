//
//  TabBarController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    weak var coordinator: TabBarCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([HomeViewController()], animated: true)
    }
}
