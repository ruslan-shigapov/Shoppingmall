//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2023.
//

import Foundation

protocol OnboardingPageViewDelegate {
    var skipButtonWasPressed: (() -> Void)? { get set }
    var confirmButtonWasPressed: (() -> Void)? { get set }
    var rejectButtonWasPressed: (() -> Void)? { get set }
}

protocol OnboardingViewModelProtocol: OnboardingPageViewDelegate {
    var pages: [OnboardingPage] { get }
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var skipButtonWasPressed: (() -> Void)?
    var confirmButtonWasPressed: (() -> Void)?
    var rejectButtonWasPressed: (() -> Void)?
    
    let pages = OnboardingPage.allCases
}
