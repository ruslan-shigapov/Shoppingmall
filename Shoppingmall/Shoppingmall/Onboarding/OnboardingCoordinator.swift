//
//  OnboardingCoordinator.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 20.11.2023.
//

import UIKit

final class OnboardingCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.coordinator = self
        navigationController.pushViewController(onboardingVC, animated: true)
    }
    
    func skipOnboarding() {
        UserDefaults.standard.set(
            true,
            forKey: UserDefaultsNamespace.shared.onboardingWasViewedKey
        )
        
        // TODO: разобраться, как реализовать инициализацию нового NavigationController
    }
}
