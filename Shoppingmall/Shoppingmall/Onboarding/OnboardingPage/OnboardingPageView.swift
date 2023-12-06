//
//  OnboardingPageView.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 11.11.2023.
//

import UIKit

final class OnboardingPageView: UIView {
    
    // MARK: Views
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var imageView = UIImageView()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel]
        )
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lowerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [pageControl]
        )
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(textStackView)
        addSubview(lowerStackView)
        addSubview(skipButton)
        subviews.forEach(prepareForAutoLayout)
        setConstraints()
    }
    
    private func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func skipButtonWasPressed() {
//        coordinator?.skipOnboarding() TODO: delegate
    }
    
    func configureFor(currentPage: OnboardingPage) {
        switch currentPage {
        case .first, .second:
            backgroundView.backgroundColor = currentPage.color
            imageView.image = currentPage.image
            titleLabel.text = currentPage.title
            pageControl.currentPage = currentPage.rawValue
        case .third, .fourth:
            backgroundView.backgroundColor = currentPage.color
            imageView.image = currentPage.image
            titleLabel.text = currentPage.title
            pageControl.currentPage = currentPage.rawValue
        }
        // TODO: добаваить логику отображения элементов на других страницах
    }
}

// MARK: - Layout Constraints
extension OnboardingPageView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            
            imageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12
            ),
            imageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -12
            ),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: -85
            ),
            
            textStackView.bottomAnchor.constraint(
                equalTo: lowerStackView.topAnchor,
                constant: -32
            ),
            textStackView.widthAnchor.constraint(equalToConstant: 190),
            textStackView.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),

            lowerStackView.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24
            ),
            lowerStackView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24
            ),
            lowerStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24
            ),
                                    
            skipButton.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: 16
            ),
            skipButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            skipButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -24
            )
        ])
    }
}

