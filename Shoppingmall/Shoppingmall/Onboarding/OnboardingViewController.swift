//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 26.01.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {

    // MARK: Dependencies
    weak var coordinator: OnboardingCoordinator?
    
    private let viewModel: OnboardingViewModel
    
    // MARK: Views
    private let pageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(
            self,
            action: #selector(skipButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialize
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(pageScrollView)
        view.addSubview(skipButton)
        setupPageScrollView(with: viewModel.pageViews)
        setConstraints()
    }
    
    private func setupPageScrollView(with pageViews: [OnboardingPageView]) {
        pageScrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(pageViews.count),
            height: pageScrollView.frame.height)
        
        for (index, pageView) in pageViews.enumerated() {
            pageView.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height * 0.75)
            
            pageScrollView.addSubview(pageView)
        }
    }
    
    @objc private func skipButtonTapped() {
        coordinator?.skipOnboarding()
    }
}

// MARK: - Layout
private extension OnboardingViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            pageScrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, 
                constant: 16),
            pageScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            pageScrollView.heightAnchor.constraint(
                equalToConstant: view.frame.height * 0.75),
            pageScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            skipButton.topAnchor.constraint(
                equalTo: pageScrollView.bottomAnchor,
                constant: 16),
            skipButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
