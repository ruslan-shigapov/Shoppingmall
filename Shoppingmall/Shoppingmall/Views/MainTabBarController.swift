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
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .deepBlue
        tabBar.layer.cornerRadius = 16
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.24
        let path = UIBezierPath(
            roundedRect: tabBar.bounds,
            cornerRadius: tabBar.layer.cornerRadius)
        tabBar.layer.shadowPath = path.cgPath
    }
    
    private func setViewControllers() {
        setViewControllers(
            [
                generateNavigationController(
                    for: ScreenFactory.getHomeViewController(),
                    withTabBarIcon: Constants.Images.TabBarIcons.home,
                    andTabBarTitle: Constants.Texts.TabBarTitles.home),
                generateNavigationController(
                    for: ScreenFactory.getCatalogueViewController(),
                    withTabBarIcon: Constants.Images.TabBarIcons.catalogue,
                    andTabBarTitle: Constants.Texts.TabBarTitles.catalogue),
                generateNavigationController(
                    for: ScreenFactory.getBonusViewController(),
                    withTabBarIcon: Constants.Images.TabBarIcons.bonus,
                    andTabBarTitle: Constants.Texts.TabBarTitles.bonus),
                generateNavigationController(
                    for: ScreenFactory.getMenuViewController(),
                    withTabBarIcon: Constants.Images.TabBarIcons.menu,
                    andTabBarTitle: Constants.Texts.TabBarTitles.menu)
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
