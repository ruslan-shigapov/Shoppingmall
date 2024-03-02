//
//  OnboardingPage.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 12.02.2024.
//

import UIKit

enum OnboardingPage: Int, CaseIterable {
    case first
    case second
    case third
    case fourth 
    
    var color: UIColor {
        switch self {
        case .first: Constants.Colors.customBlue
        case .second: Constants.Colors.customPink
        case .third: Constants.Colors.customBlue
        case .fourth: Constants.Colors.customBlack
        }
    }
    
    var image: UIImage {
        UIImage(named: "Onboarding\(self.rawValue)")!
    }
    
    var title: String {
        switch self {
        case .first: Constants.Text.Onboarding.firstPageTitle
        case .second: Constants.Text.Onboarding.secondPageTitle
        case .third: Constants.Text.Onboarding.thirdPageTitle
        case .fourth: Constants.Text.Onboarding.fourthPageTitle
        }
    }
    
    var description: String? {
        switch self {
        case .third: Constants.Text.Onboarding.thirdPageDescription
        case .fourth: Constants.Text.Onboarding.fourthPageDescription
        default: nil
        }
    }
    
    var confirmButtonTitle: String? {
        switch self {
        case .third: Constants.Text.Onboarding.thirdPageConfirmButtonTitle
        case .fourth: Constants.Text.Onboarding.fourthPageConfirmButtonTitle
        default: nil
        }
    }
    
    var secondaryButtonTitle: String? {
        switch self {
        case .third: Constants.Text.Onboarding.thirdPageSecondaryButtonTitle
        case .fourth: Constants.Text.Onboarding.fourthPageSecondaryButtonTitle
        default: nil
        }
    }
}
