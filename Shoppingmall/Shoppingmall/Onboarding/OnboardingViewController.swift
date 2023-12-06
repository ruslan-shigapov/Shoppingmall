//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 29.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var pageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
        
    private let viewModel = OnboardingViewModel()
    weak var coordinator: OnboardingCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.titleView = LogoTitleView()
        view.backgroundColor = .systemBackground
        view.addSubview(pageScrollView)
        setConstraints()
        setupPageScrollView(with: viewModel.pages)
    }
    
    private func setupPageScrollView(with pages: [OnboardingPageView]) {
        pageScrollView.contentSize = CGSize(
            width: view.frame.width * CGFloat(pages.count),
            height: pageScrollView.frame.height
        )
        for (index, page) in pages.enumerated() {
            page.frame = CGRect(
                x: view.frame.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height * 0.85
            )
            pageScrollView.addSubview(page)
        }
    }
}

// MARK: - Layout Constraints
extension OnboardingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageScrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            pageScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            pageScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            pageScrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
