//
//  AppCoordinator.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 20.11.2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow
    private var navigationController = UINavigationController()
    
    private lazy var isFirstLaunching: Bool = {
        !UserDefaults.standard.bool(
            forKey: UserDefaultsNamespace.shared.onboardingWasViewedKey
        )
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        runCoordinator(
            isFirstLaunching
            ? OnboardingCoordinator(navigationController: navigationController)
            : TabBarCoordinator(navigationController: navigationController)
        )
    }
    
    private func runCoordinator(_ coordinator: Coordinator) {
        add(coordinator: coordinator)
        coordinator.start()
    }
}
