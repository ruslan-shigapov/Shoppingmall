//
//  OnboardingPageView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 12.02.2024.
//

import UIKit

final class OnboardingPageView: UIView {
    
    private let viewModel: OnboardingPageViewModel
    
    // MARK: Views
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = viewModel.backgroundColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var illustrationImageView: UIImageView = {
        let view = UIImageView(image: viewModel.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.description
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        if viewModel.isInteractivePage {
            stackView.addArrangedSubview(descriptionLabel)
        }
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var confirmButton: UIButton = {
        let primaryButton = PrimaryButton(
            color: .white,
            title: viewModel.confirmButtonTitle,
            titleColor: Constants.Colors.customBlue,
            titleSize: 16,
            height: 34)
        return primaryButton
    }()
    
    private lazy var secondaryButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel.secondaryButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [confirmButton, secondaryButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = viewModel.currentNumber
        pageControl.isEnabled = false
        return pageControl
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if viewModel.isInteractivePage {
            stackView.addArrangedSubview(buttonStackView)
        }
        stackView.addArrangedSubview(pageControl)
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()

    // MARK: Initialize
    init(viewModel: OnboardingPageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(illustrationImageView)
        addSubview(contentStackView)
        setConstraints()
    }
}

// MARK: - Layout
private extension OnboardingPageView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            
            illustrationImageView.heightAnchor.constraint(
                equalToConstant: viewModel.isInteractivePage ? 290 : 340),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: viewModel.isInteractivePage ? 34 : 10),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: viewModel.isInteractivePage ? -34 : -10),

            contentStackView.topAnchor.constraint(
                equalTo: illustrationImageView.bottomAnchor,
                constant: viewModel.isInteractivePage ? 0 : 70),
            contentStackView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24),
            contentStackView.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24),
            contentStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24)
        ])
    }
}
