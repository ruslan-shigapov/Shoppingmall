//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2023.
//

import Foundation

final class OnboardingViewModel {
    
    let pages: [OnboardingPageView] = {
        let pages = OnboardingPage.allCases.map {
            let pageView = OnboardingPageView()
            pageView.configureFor(currentPage: $0)
            return pageView
        }
        return pages
    }()
}
