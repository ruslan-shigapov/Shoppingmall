//
//  OnboardingPageViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 13.02.2024.
//

import UIKit

final class OnboardingPageViewModel {
    
    var backgroundColor: UIColor {
        currentPage.color
    }
    
    var image: UIImage {
        currentPage.image
    }
    
    var title: String {
        currentPage.title
    }
    
    var description: String? {
        currentPage.description
    }
    
    var confirmButtonTitle: String? {
        currentPage.confirmButtonTitle
    }
    
    var secondaryButtonTitle: String? {
        currentPage.secondaryButtonTitle
    }
    
    var currentNumber: Int {
        currentPage.rawValue
    }
    
    var isInteractivePage: Bool {
        currentPage == .third || currentPage == .fourth
    }
    
    private let currentPage: OnboardingPage
    
    required init(currentPage: OnboardingPage) {
        self.currentPage = currentPage
    }
}
