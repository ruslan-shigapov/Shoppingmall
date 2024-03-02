//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 12.02.2024.
//

final class OnboardingViewModel {
    
    private let pages = OnboardingPage.allCases
    
    var pageViews: [OnboardingPageView] {
        pages.map {
            let currentViewModel = OnboardingPageViewModel(currentPage: $0)
            return OnboardingPageView(viewModel: currentViewModel)
        }
    }
}
