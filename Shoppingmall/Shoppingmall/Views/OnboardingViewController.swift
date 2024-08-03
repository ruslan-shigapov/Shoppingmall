//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingScrollView = OnboardingScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(onboardingScrollView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            onboardingScrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            onboardingScrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            onboardingScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
