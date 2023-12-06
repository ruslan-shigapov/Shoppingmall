//
//  OnboardingPage.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 15.11.2023.
//

import UIKit

enum OnboardingPage: Int, CaseIterable {
    case first
    case second
    case third
    case fourth
    
    var color: UIColor? {
        switch self {
        case .first: Constants.Colors.deepBlue
        case .second: Constants.Colors.ligthPink
        case .third: Constants.Colors.deepBlue
        case .fourth: Constants.Colors.ligthBlack
        }
    }
    
    var image: UIImage? {
        UIImage(named: "Onboarding\(self.rawValue)")
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
    
    var mainButtonTitle: String? {
        switch self {
        case .third: Constants.Text.ButtonTitle.allow
        case .fourth: Constants.Text.ButtonTitle.register
        default: nil
        }
    }
    
    var secondaryButtonTitle: String? {
        switch self {
        case .third: Constants.Text.ButtonTitle.sooner
        case .fourth: Constants.Text.ButtonTitle.alreadyRegistered
        default: nil
        }
    }
}
