//
//  OnboardingPageViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.12.2023.
//

import UIKit

protocol OnboardingPageViewModelProtocol {
    var pageNumber: Int { get }
    var isInteractivePage: Bool { get }
    var backgroundColor: UIColor { get }
    var image: UIImage { get }
    var title: String { get }
    var description: String? { get }
    var mainButtonTitle: String? { get }
    var rejectButtonTitle: String? { get }
    init(currentPage: OnboardingPage)
}

final class OnboardingPageViewModel: OnboardingPageViewModelProtocol {
    
    private let currentPage: OnboardingPage
    
    var pageNumber: Int {
        currentPage.rawValue
    }
    
    var isInteractivePage: Bool {
        currentPage == .third || currentPage == .fourth
    }
    
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
    
    var mainButtonTitle: String? {
        currentPage.mainButtonTitle
    }
    
    var rejectButtonTitle: String? {
        currentPage.rejectButtonTitle
    }
    
    required init(currentPage: OnboardingPage) {
        self.currentPage = currentPage
    }
}
