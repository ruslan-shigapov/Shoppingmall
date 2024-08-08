//
//  MainTabBarController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.08.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setViewControllers()
    }
    
    private func setupUI() {
        tabBar.barTintColor = .lightGray
        tabBar.tintColor = .deepBlue
        
    }
    
    private func setViewControllers() {
        setViewControllers(
            [
                generateNavigationController(
                    for: ScreenFactory.makeHomeViewController(),
                    withTabBarIcon: Constants.Images.homeIcon,
                    andTabBarTitle: Constants.Texts.TabBarTitles.home),
                generateNavigationController(
                    for: ScreenFactory.makeBonusViewController(),
                    withTabBarIcon: Constants.Images.bonusIcon,
                    andTabBarTitle: Constants.Texts.TabBarTitles.bonus)
            ],
            animated: true)
    }
    
    private func generateNavigationController(
        for viewController: UIViewController,
        withTabBarIcon image: UIImage?,
        andTabBarTitle title: String?
    ) -> UINavigationController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return UINavigationController(rootViewController: viewController)
    }
}
