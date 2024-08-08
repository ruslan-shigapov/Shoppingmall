//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Private Properties
    private let viewModel: OnboardingViewModelProtocol
    
    // MARK: Views
    private let titleImageView = UIImageView(image: Constants.Images.appName)
    
    private let firstPageView = OnboardingPageView(
        color: .deepBlue,
        title: Constants.Texts.firstPageTitle,
        currentPage: 0)
    private let secondPageView = OnboardingPageView(
        color: .milkyPink,
        title: Constants.Texts.secondPageTitle,
        currentPage: 1)
    private let thirdPageView = OnboardingPageView(
        color: .deepBlue,
        title: Constants.Texts.thirdPageTitle,
        currentPage: 2,
        description: Constants.Texts.thirdPageDescription,
        primaryButtonTitle: Constants.Texts.ButtonTitles.allow,
        secondaryButtonTitle: Constants.Texts.ButtonTitles.later)
    private let fourthPageView = OnboardingPageView(
        color: .smokyBlack,
        title: Constants.Texts.fourthPageTitle,
        currentPage: 3,
        description: Constants.Texts.fourthPageDescription,
        primaryButtonTitle: Constants.Texts.ButtonTitles.register,
        secondaryButtonTitle: Constants.Texts.ButtonTitles.alreadyRegistered)
    
    private lazy var onboardingScrollView = OnboardingScrollView(
        pageViews: [
            firstPageView,
            secondPageView,
            thirdPageView,
            fourthPageView])
    
    private lazy var skipButton: SecondaryButton = {
        let button = SecondaryButton(color: .lightGray)
        button.setTitle(Constants.Texts.ButtonTitles.skip, for: .normal)
        button.addTarget(
            self,
            action: #selector(skipButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(titleImageView, onboardingScrollView, skipButton)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func addActions() {
        thirdPageView.addTarget(
            self,
            primaryAction: #selector(allowButtonTapped),
            secondaryAction: #selector(laterButtonTapped))
        fourthPageView.addTarget(
            self,
            primaryAction: #selector(registerButtonTapped),
            secondaryAction: #selector(alreadyRegisteredButtonTapped))
    }
    
    private func scrollToLastPage() {
        let fourthPageViewContentOffset = CGPoint(
            x: onboardingScrollView.frame.width * 3,
            y: 0)
        onboardingScrollView.setContentOffset(
            fourthPageViewContentOffset,
            animated: true)
    }
    
    @objc private func skipButtonTapped() {
        viewModel.setFirstLaunch(value: true)
        dismiss(animated: true)
    }
    
    @objc private func allowButtonTapped() {
        viewModel.requestNotificationPermission { [weak self] in
            guard let self else { return }
            scrollToLastPage()
        }
    }
    
    @objc private func laterButtonTapped() {
        scrollToLastPage()
    }
    
    @objc private func registerButtonTapped() {}
    @objc private func alreadyRegisteredButtonTapped() {}
}

// MARK: - Layout
private extension OnboardingViewController {
    
    func setConstraints() {
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
