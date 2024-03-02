//
//  OnboardingCoordinator.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

final class OnboardingCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingVC = OnboardingViewController(
            viewModel: onboardingViewModel)
        onboardingVC.coordinator = self
//        UserDefaults.standard.set(true, forKey: "onboardingWasViewed")
        navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    func skipOnboarding() {
        didFinish?()
    }
}
