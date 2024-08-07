//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Views
    private let titleImageView = UIImageView(image: Constants.Images.appName)

    private let onboardingScrollView = OnboardingScrollView()
    
    private let skipButton: SecondaryButton = {
        let button = SecondaryButton(color: .lightGray)
        button.setTitle(Constants.Texts.ButtonTitles.skip, for: .normal)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(titleImageView, onboardingScrollView, skipButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40),
            titleImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            titleImageView.heightAnchor.constraint(equalToConstant: 18),
            titleImageView.widthAnchor.constraint(equalToConstant: 120),
            
            onboardingScrollView.topAnchor.constraint(
                equalTo: titleImageView.bottomAnchor,
                constant: 24),
            onboardingScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            onboardingScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            skipButton.topAnchor.constraint(
                equalTo: onboardingScrollView.bottomAnchor,
                constant: 16),
            skipButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            skipButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
