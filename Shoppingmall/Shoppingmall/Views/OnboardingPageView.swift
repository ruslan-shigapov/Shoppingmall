//
//  OnboardingPageView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingPageView: UIView {
    
    // MARK: Views
    private let roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let primaryButton = PrimaryButton(color: .white)
    
    private let secondaryButton = SecondaryButton(color: .white)
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [primaryButton, secondaryButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        return pageControl
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [labelStackView, buttonStackView, pageControl])
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()

    // MARK: Initialize
    init(
        color: UIColor,
        title: String,
        currentPage: Int,
        description: String? = nil,
        primaryButtonTitle: String? = nil,
        secondaryButtonTitle: String? = nil
    ) {
        super.init(frame: .zero)
        roundedView.backgroundColor = color
        titleLabel.text = title
        descriptionLabel.text = description
        primaryButton.setTitle(primaryButtonTitle, for: .normal)
        secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
        pageControl.currentPage = currentPage
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupContent()
        addSubviews(roundedView, containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupContent() {
        if descriptionLabel.text == nil {
            labelStackView.removeArrangedSubview(descriptionLabel)
            containerStackView.removeArrangedSubview(buttonStackView)
            primaryButton.isHidden = true
        }
    }
}

// MARK: - Layout
private extension OnboardingPageView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            roundedView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24),
            roundedView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16),
            roundedView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            
            containerStackView.leadingAnchor.constraint(
                equalTo: roundedView.leadingAnchor,
                constant: 24),
            containerStackView.bottomAnchor.constraint(
                equalTo: roundedView.bottomAnchor,
                constant: -24),
            containerStackView.trailingAnchor.constraint(
                equalTo: roundedView.trailingAnchor,
                constant: -24),
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
