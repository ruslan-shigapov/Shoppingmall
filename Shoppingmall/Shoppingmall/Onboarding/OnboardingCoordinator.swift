//
//  OnboardingCoordinator.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 20.11.2023.
//

import UIKit

class OnboardingCoordinator: BaseCoordinator {
    
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
        
    }
}
