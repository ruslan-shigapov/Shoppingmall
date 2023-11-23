//
//  OnboardingViewModel.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 15.11.2023.
//

import Foundation

protocol OnboardingViewModelProtocol {
    var currentPage: OnboardingPage { get }
    var viewModelDidChange: ((OnboardingViewModelProtocol) -> Void)? { get set }
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var currentPage: OnboardingPage = .first
    
    var viewModelDidChange: ((OnboardingViewModelProtocol) -> Void)?
    
    // TODO: реализовать перелистывание
}
