//
//  ScreenFactory.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import UIKit

struct ScreenFactory {
    
    static func getRootViewController() -> UIViewController {
        let isNotFirstLaunch = UserDefaults.standard.bool(
            forKey: "isNotFirstLaunch")
        return isNotFirstLaunch
        ? MainTabBarController()
        : getOnboardingViewController()
    }
    
    static func getOnboardingViewController() -> OnboardingViewController {
        let viewModel = OnboardingViewModel()
        return OnboardingViewController(viewModel: viewModel)
    }
    
    static func getHomeViewController() -> HomeViewController {
        let viewModel = HomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
    
    static func getBonusViewController() -> BonusViewController {
        BonusViewController()
    }
}
