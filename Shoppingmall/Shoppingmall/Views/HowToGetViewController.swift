//
//  HowToGetViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2024.
//

import UIKit

final class HowToGetViewController: UIViewController {
    
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
        title: Constants.Texts.MenuTitles.howToGet.rawValue)
    
    private let mapImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Images.map)
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private lazy var showMapButton: PrimaryButton = {
        let primaryButton = PrimaryButton(color: .lightGray)
        primaryButton.setTitle("перейти в Яндекс Карты", for: .normal)
        primaryButton.addTarget(
            self,
            action: #selector(showMapButtonTapped),
            for: .touchUpInside)
        return primaryButton
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "QuestionPin"))
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = "ул. Уральская д. 4/1"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubviews(
            mapImageView,
            showMapButton,
            iconImageView,
            addressLabel)
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
    
    @objc private func showMapButtonTapped() {
        let mapViewController = MapViewController()
        present(mapViewController, animated: true)
    }
}

// MARK: - Layout
private extension HowToGetViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mapImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            mapImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            mapImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            mapImageView.heightAnchor.constraint(equalToConstant: 312),
            
            showMapButton.topAnchor.constraint(
                equalTo: mapImageView.bottomAnchor,
                constant: 16),
            showMapButton.leadingAnchor.constraint(
                equalTo: mapImageView.leadingAnchor),
            showMapButton.trailingAnchor.constraint(
                equalTo: mapImageView.trailingAnchor),
            
            iconImageView.topAnchor.constraint(
                equalTo: showMapButton.bottomAnchor,
                constant: 24),
            iconImageView.leadingAnchor.constraint(
                equalTo: mapImageView.leadingAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.widthAnchor.constraint(
                equalTo: iconImageView.heightAnchor),
            
            addressLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 8),
            addressLabel.centerYAnchor.constraint(
                equalTo: iconImageView.centerYAnchor)
        ])
    }
}
