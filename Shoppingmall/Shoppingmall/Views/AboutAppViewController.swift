//
//  AboutAppViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2024.
//

import UIKit

final class AboutAppViewController: UIViewController {
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Constants.Images.backArrow,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        button.tintColor = .deepBlue
        return button
    }()
    
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.MenuTitles.aboutApp.rawValue)
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        label.textColor = .black
        label.text = "Оцените приложение"
        return label
    }()
    
    private lazy var starButtons: [StarButton] = {
        var buttons: [StarButton] = []
        for index in 0..<5 {
            let starButton = StarButton()
            starButton.tag = index + 1
            starButton.addTarget(
                self,
                action: #selector(starButtonTapped),
                for: .touchUpInside)
            buttons.append(starButton)
        }
        return buttons
    }()
    
    private lazy var starButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: starButtons)
        stackView.spacing = 10
        return stackView
    }()
    
    private let rateButton: PrimaryButton = {
        let primaryButton = PrimaryButton(color: .deepBlue)
        primaryButton.setTitle("Оценить", for: .normal)
        return primaryButton
    }()
    
    private let documentationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        label.textColor = .black
        label.text = "Документация"
        return label
    }()
    
    private let termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = "Условия использования"
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clearGrey
        return view
    }()
    
    private let userAgreementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = "Пользовательское соглашение"
        return label
    }()
    
    private let firstArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.forwardArrow
        imageView.contentMode = .center
        return imageView
    }()
    
    private let secondArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.forwardArrow
        imageView.contentMode = .center
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubviews(
            rateLabel,
            starButtonStackView,
            rateButton,
            documentationLabel,
            termsOfUseLabel,
            firstArrowImageView,
            dividerView,
            userAgreementLabel,
            secondArrowImageView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleView
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func starButtonTapped(_ sender: StarButton) {
        for (index, button) in starButtons.enumerated() {
            button.isSelected = index < sender.tag
        }
    }
}

private extension AboutAppViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 57),
            rateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            starButtonStackView.topAnchor.constraint(
                equalTo: rateLabel.bottomAnchor,
                constant: 24),
            starButtonStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            
            rateButton.topAnchor.constraint(
                equalTo: starButtonStackView.bottomAnchor,
                constant: 16),
            rateButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            rateButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            documentationLabel.topAnchor.constraint(
                equalTo: rateButton.bottomAnchor,
                constant: 64),
            documentationLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            termsOfUseLabel.topAnchor.constraint(
                equalTo: documentationLabel.bottomAnchor,
                constant: 24),
            termsOfUseLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            firstArrowImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            firstArrowImageView.centerYAnchor.constraint(
                equalTo: termsOfUseLabel.centerYAnchor),
            firstArrowImageView.heightAnchor.constraint(equalToConstant: 18),
            firstArrowImageView.widthAnchor.constraint(
                equalTo: firstArrowImageView.heightAnchor),
            
            dividerView.topAnchor.constraint(
                equalTo: termsOfUseLabel.bottomAnchor,
                constant: 16),
            dividerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            dividerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            userAgreementLabel.topAnchor.constraint(
                equalTo: dividerView.bottomAnchor,
                constant: 16),
            userAgreementLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            secondArrowImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            secondArrowImageView.centerYAnchor.constraint(
                equalTo: userAgreementLabel.centerYAnchor),
            secondArrowImageView.heightAnchor.constraint(equalToConstant: 18),
            secondArrowImageView.widthAnchor.constraint(
                equalTo: secondArrowImageView.heightAnchor)
        ])
    }
}
