//
//  AppCoordinator.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 20.11.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow
    
    private var navigationController = UINavigationController()
    
    private var isFirstLaunching: Bool {
        true // TODO: добавить логику с помощью UserDefaults
    }
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        isFirstLaunching ? runOnboarding() : runTabBar()
    }
    
    private func runOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController
        )
        add(coordinator: onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func runTabBar() {
        let tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController
        )
        add(coordinator: tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
