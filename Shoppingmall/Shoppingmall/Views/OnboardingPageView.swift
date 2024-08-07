//
//  OnboardingPageView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class OnboardingPageView: UIView {
    
    // MARK: Private Properties
    private let currentPage: Int
    
    private var imageViewTopInset: CGFloat = 0
    private var imageViewLeadingInset: CGFloat = 0
    private var imageViewBottomInset: CGFloat = 0
    private var imageViewTrailingInset: CGFloat = 0
    
    // MARK: Views
    private let roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(named: "Illustration\(currentPage)"))
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 32)
        label.textColor = .white
        label.numberOfLines = 0
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
        stackView.spacing = 16
        return stackView
    }()
    
    private let primaryButton = PrimaryButton(color: .white)
    
    private let secondaryButton = SecondaryButton(color: .white)
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [primaryButton, secondaryButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = currentPage
        return pageControl
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [labelStackView, buttonStackView, pageControl])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillProportionally
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
        self.currentPage = currentPage
        super.init(frame: .zero)
        roundedView.backgroundColor = color
        titleLabel.text = title
        descriptionLabel.text = description
        primaryButton.setTitle(primaryButtonTitle, for: .normal)
        secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupContent()
        setImageViewInsets()
        addSubviews(roundedView, illustrationImageView, containerStackView)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupContent() {
        if descriptionLabel.text == nil {
            labelStackView.removeArrangedSubview(descriptionLabel)
            containerStackView.removeArrangedSubview(buttonStackView)
            primaryButton.isHidden = true
            secondaryButton.isHidden = true
        }
    }
    
    private func setImageViewInsets() {
        switch currentPage {
        case 0:
            imageViewTopInset = 72
            imageViewLeadingInset = 10
            imageViewBottomInset = -61
            imageViewTrailingInset = -10
        case 1:
            imageViewTopInset = 57
            imageViewBottomInset = -65
        case 2:
            imageViewLeadingInset = 34
            imageViewBottomInset = -2
            imageViewTrailingInset = -42
        case 3:
            imageViewTopInset = 51
            imageViewLeadingInset = 28
            imageViewBottomInset = -2
            imageViewTrailingInset = -28
        default: break
        }
    }
}

// MARK: - Layout
private extension OnboardingPageView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: topAnchor),
            roundedView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24),
            roundedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            
            illustrationImageView.topAnchor.constraint(
                equalTo: roundedView.topAnchor,
                constant: imageViewTopInset),
            illustrationImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: imageViewLeadingInset),
            illustrationImageView.bottomAnchor.constraint(
                equalTo: containerStackView.topAnchor,
                constant: imageViewBottomInset),
            illustrationImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: imageViewTrailingInset),
            
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
