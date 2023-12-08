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
        view.backgroundColor = viewModel.backgroundColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.image
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textStackView])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel]
        )
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.font = .systemFont(ofSize: 28)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.description
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [confirmButton, rejectButton]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = ConfirmButton(
            color: .white,
            title: viewModel.mainButtonTitle,
            titleColor: .deepBlue
        )
        button.addTarget(
            self,
            action: #selector(confirmButtonWasPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var rejectButton: UIButton = {
        let button = OrdinaryButton(
            color: .clear,
            title: viewModel.rejectButtonTitle,
            titleColor: .white
        )
        button.addTarget(
            self,
            action: #selector(rejectButtonWasPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = viewModel.pageNumber
        pageControl.isEnabled = false
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
    
    // MARK: Dependency Injection
    private var viewModel: OnboardingPageViewModelProtocol
    var delegate: OnboardingPageViewDelegate?
    
    // MARK: Initialization
    init(viewModel: OnboardingPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(mainStackView)
        addSubview(pageControl)
        addSubview(skipButton)
        subviews.forEach(prepareForAutoLayout)
        if viewModel.isInteractivePage {
            textStackView.addArrangedSubview(descriptionLabel)
            mainStackView.addArrangedSubview(buttonsStackView)
        }
        setConstraints()
    }
    
    private func prepareForAutoLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Actions
    @objc private func skipButtonWasPressed() {
        delegate?.skipButtonWasPressed?()
    }
    
    @objc private func confirmButtonWasPressed() {
        delegate?.confirmButtonWasPressed?()
    }
    
    @objc private func rejectButtonWasPressed() {
        delegate?.rejectButtonWasPressed?()
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

            mainStackView.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: viewModel.isInteractivePage ? 10 : 100
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: viewModel.isInteractivePage ? 24 : 72
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: viewModel.isInteractivePage ? -24 : -72
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor,
                constant: -24
            ),
            mainStackView.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 34),

            pageControl.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -24
            ),
            pageControl.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 24
            ),
            pageControl.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -24
            ),
                                    
            skipButton.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: 10
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

