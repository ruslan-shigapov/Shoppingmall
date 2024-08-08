//
//  ScreenFactory.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import UIKit

struct ScreenFactory {
    
    static func makeRootViewController() -> UIViewController {
        let isNotFirstLaunch = UserDefaults.standard.bool(
            forKey: "isNotFirstLaunch")
        return isNotFirstLaunch
        ? MainTabBarController()
        : makeOnboardingViewController()
    }
    
    static func makeOnboardingViewController() -> OnboardingViewController {
        let viewModel = OnboardingViewModel()
        return OnboardingViewController(viewModel: viewModel)
    }
    
    static func makeHomeViewController() -> HomeViewController {
        let viewModel = HomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
    
    static func makeBonusViewController() -> BonusViewController {
        BonusViewController()
    }
}
