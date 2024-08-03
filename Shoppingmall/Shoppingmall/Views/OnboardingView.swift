//
//  OnboardingView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

// TODO: rename to Page?
final class OnboardingView: UIView {
    
    // MARK: Views
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    // TODO: create constants
    // TODO: replace labels?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
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
    
    // TODO: replace buttons
    private let primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitleColor(.deepBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16)
        button.heightAnchor.constraint(equalToConstant: 34).isActive = true
        return button
    }()
    
    private let secondaryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14)
        return button
    }()
    
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
    
    // TODO: crate extension
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [labelStackView, buttonStackView, pageControl])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()

    // MARK: Initialize
    init(
        color: UIColor,
        title: String,
        description: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        currentPage: Int
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
        addSubview(roundedView)
        addSubview(containerStackView)
        setConstraints()
    }
    
    // TODO: create public method for configure
    
    private func setConstraints() {
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
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
