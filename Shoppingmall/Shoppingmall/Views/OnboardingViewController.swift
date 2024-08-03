//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // TODO: try to use different onboarding styles
    let onboardingView = OnboardingPageView(pageType: .interactive, color: .deepBlue, title: "Узнавайте первыми", currentPage: 2, description: "Разрешите уведомления, чтобы узнавать о начисленных бонусах и специальных предложениях", primaryButtonTitle: "Разрешить", secondaryButtonTitle: "Позже")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboardingView)
        onboardingView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        onboardingView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        onboardingView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        onboardingView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
    }
}
