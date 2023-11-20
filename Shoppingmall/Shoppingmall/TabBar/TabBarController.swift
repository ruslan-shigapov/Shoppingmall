//
//  TabBarController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 10.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    weak var coordinator: TabBarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        setViewControllers([
                HomeViewController()
                // TODO: добавить другие контроллеры
            ],
            animated: true
        )
        // TODO: настроить иконки 
    }
}
