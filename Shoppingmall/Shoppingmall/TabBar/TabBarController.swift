//
//  TabBarController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 10.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        setViewControllers([
                HomeViewController()
                // TODO: add another VCs
            ],
            animated: true
        )
        // TODO: setup tab bar items
    }
}
