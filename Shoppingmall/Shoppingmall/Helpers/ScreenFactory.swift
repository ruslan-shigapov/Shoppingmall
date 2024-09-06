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
    
    static func getCatalogueViewController() -> CatalogueViewController {
        let viewModel = CatalogueViewModel()
        return CatalogueViewController(viewModel: viewModel)
    }
    
    static func getCategoryViewController(
        category: Category
    ) -> CategoryViewController {
        let viewModel = CategoryViewModel(category: category)
        return CategoryViewController(viewModel: viewModel)
    }
    
    static func getBonusViewController() -> BonusViewController {
        BonusViewController()
    }
    
    static func getMenuViewController() -> MenuViewController {
        MenuViewController()
    }
}
