//
//  BonusViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import UIKit

final class BonusViewController: UIViewController {
    
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.TabBarTitles.bonus)
    
    private let pageView = OnboardingPageView(
        color: .smokyBlack,
        title: Constants.Texts.Onboarding.fourthPageTitle,
        currentPage: 3,
        description: Constants.Texts.Onboarding.fourthPageDescription,
        primaryButtonTitle: Constants.Texts.ButtonTitles.register,
        secondaryButtonTitle: Constants.Texts.ButtonTitles.alreadyRegistered)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubview(pageView)
        view.prepareForAutoLayout()
        setConstraints()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -72),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
