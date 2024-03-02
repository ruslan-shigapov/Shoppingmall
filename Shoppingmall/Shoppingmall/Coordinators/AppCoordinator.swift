//
//  AppCoordinator.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private var window: UIWindow
    private let navigationController = UINavigationController()
    
    private var isFirstLaunching: Bool {
        !UserDefaults.standard.bool(forKey: "onboardingWasViewed")
    }
        
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let initialCoordinator = isFirstLaunching
        ? OnboardingCoordinator(navigationController: navigationController)
        : TabBarCoordinator(navigationController: navigationController)
        
        run(coordinator: initialCoordinator)
        setupNavigationController()
    }
    
    private func run(coordinator: Coordinator) {
        add(coordinator: coordinator)
        coordinator.didFinish = { [weak self] in
            self?.childCoordinators.removeAll()
            self?.start()
        }
        coordinator.start()
    }
    
    private func setupNavigationController() {
        if let currentVC = navigationController.topViewController {
            currentVC.navigationItem.titleView = LogoView()
        }
    }
}
