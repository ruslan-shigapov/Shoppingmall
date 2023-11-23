//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 11.11.2023.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    // TODO: разобраться, как работает этот контроллер (свайпы и т.д.)
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.logo
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var imageView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        return pageControl
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Text.ButtonTitle.skip, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(
            self,
            action: #selector(skipButtonWasPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    weak var coordinator: OnboardingCoordinator?
    
    private var viewModel: OnboardingViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { [weak self] _ in
                self?.configureUI()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnboardingViewModel()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = logoView
        
        addSubviews()
        view.subviews.forEach(prepareForAutoLayout)
        setConstraints()
        configureUI()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
    }
    
    private func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureUI() {
        backgroundView.backgroundColor = viewModel.currentPage.color
        imageView.image = viewModel.currentPage.image
        titleLabel.text = viewModel.currentPage.title
        pageControl.currentPage = viewModel.currentPage.rawValue
    }
    
    @objc private func skipButtonWasPressed() {
        coordinator?.skipOnboarding()
    }
}

// MARK: - Layout Constraints
extension OnboardingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 120),
            logoView.heightAnchor.constraint(equalToConstant: 20),
            
            backgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 12
            ),
            imageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -12
            ),
            imageView.heightAnchor.constraint(equalToConstant: 235),
            imageView.centerYAnchor.constraint(
                equalTo: backgroundView.centerYAnchor,
                constant: -60
            ),

            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24
            ),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor,
                constant: -32
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            skipButton.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor, 
                constant: 16
            ),
            skipButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            skipButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -50
            )
        ])
    }
}

