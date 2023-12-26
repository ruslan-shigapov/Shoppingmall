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
        
    private var viewModel: OnboardingViewModelProtocol! {
        didSet {
            viewModel.skipButtonWasPressed = { [weak self] in
                self?.coordinator?.skipOnboarding()
            }
            viewModel.confirmButtonWasPressed = { page in
                if page == .third {
                    
                } else if page == .fourth {
                    
                }
            }
            viewModel.rejectButtonWasPressed = { page in
                
            }
        }
    }
    weak var coordinator: OnboardingCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnboardingViewModel()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.titleView = LogoTitleView()
        view.backgroundColor = .systemBackground
        view.addSubview(pageScrollView)
        setConstraints()
        setupPageScrollView(with: createOnboardingPageViews())
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
    
    private func createOnboardingPageViews() -> [OnboardingPageView] {
        viewModel.pages.map {
            let pageView = OnboardingPageView(
                viewModel: OnboardingPageViewModel(currentPage: $0)
            )
            pageView.delegate = viewModel as OnboardingPageViewDelegate
            return pageView
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
