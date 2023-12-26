//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2023.
//

import Foundation

protocol OnboardingPageViewDelegate {
    var skipButtonWasPressed: (() -> Void)? { get set }
    var confirmButtonWasPressed: ((OnboardingPage) -> Void)? { get set }
    var rejectButtonWasPressed: ((OnboardingPage) -> Void)? { get set }
}

protocol OnboardingViewModelProtocol: OnboardingPageViewDelegate {
    var pages: [OnboardingPage] { get }
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var skipButtonWasPressed: (() -> Void)?
    var confirmButtonWasPressed: ((OnboardingPage) -> Void)?
    var rejectButtonWasPressed: ((OnboardingPage) -> Void)?
    
    let pages = OnboardingPage.allCases
}
