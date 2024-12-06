//
//  SettingsViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 22.11.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: Views
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
        title: Constants.Texts.MenuTitles.settings.rawValue)
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        label.textColor = .black
        label.text = Constants.Texts.Settings.notifications
        return label
    }()
    
    private let offersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = Constants.Texts.Settings.offers
        return label
    }()
    
    private let kidsEventsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = Constants.Texts.Settings.kidsEvents
        return label
    }()
    
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = Constants.Texts.Settings.events
        return label
    }()
    
    private let loginOrRegistrationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        label.text = Constants.Texts.Settings.loginOrRegistration
        return label
    }()
    
    private let firstDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clearGrey
        return view
    }()
    
    private let secondDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clearGrey
        return view
    }()
    
    private let entranceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.entrance
        return imageView
    }()
    
    private let offersSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .deepBlue
        return switcher
    }()
    
    private let kidsEventsSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .deepBlue
        return switcher
    }()
    
    private lazy var eventsSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .deepBlue
        return switcher
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        setupSwitcher()
        view.backgroundColor = .white
        view.addSubviews(
            notificationsLabel,
            offersLabel,
            offersSwitcher,
            firstDividerView,
            kidsEventsLabel,
            kidsEventsSwitcher,
            secondDividerView,
            eventsLabel,
            eventsSwitcher,
            entranceImageView,
            loginOrRegistrationLabel
        )
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleView
    }
    
    private func setupSwitcher() {
        NotificationManager.shared.checkPermission { [weak self] isEnabled in
            guard let self else { return }
            DispatchQueue.main.async {
                self.eventsSwitcher.isOn = isEnabled
            }
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Layout
private extension SettingsViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            notificationsLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            notificationsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            offersLabel.topAnchor.constraint(
                equalTo: notificationsLabel.bottomAnchor,
                constant: 24),
            offersLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            offersSwitcher.centerYAnchor.constraint(
                equalTo: offersLabel.centerYAnchor),
            offersSwitcher.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            firstDividerView.topAnchor.constraint(
                equalTo: offersLabel.bottomAnchor,
                constant: 16),
            firstDividerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            firstDividerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            firstDividerView.heightAnchor.constraint(equalToConstant: 2),
            
            kidsEventsLabel.topAnchor.constraint(
                equalTo: firstDividerView.bottomAnchor,
                constant: 16),
            kidsEventsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            kidsEventsSwitcher.centerYAnchor.constraint(
                equalTo: kidsEventsLabel.centerYAnchor),
            kidsEventsSwitcher.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            secondDividerView.topAnchor.constraint(
                equalTo: kidsEventsLabel.bottomAnchor,
                constant: 16),
            secondDividerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            secondDividerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            secondDividerView.heightAnchor.constraint(equalToConstant: 2),
            
            eventsLabel.topAnchor.constraint(
                equalTo: secondDividerView.bottomAnchor,
                constant: 16),
            eventsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            eventsSwitcher.centerYAnchor.constraint(
                equalTo: eventsLabel.centerYAnchor),
            eventsSwitcher.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            entranceImageView.topAnchor.constraint(
                equalTo: eventsLabel.bottomAnchor,
                constant: 48),
            entranceImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            entranceImageView.heightAnchor.constraint(equalToConstant: 18),
            entranceImageView.widthAnchor.constraint(
                equalTo: entranceImageView.heightAnchor),
            
            loginOrRegistrationLabel.leadingAnchor.constraint(
                equalTo: entranceImageView.trailingAnchor,
                constant: 8),
            loginOrRegistrationLabel.centerYAnchor.constraint(
                equalTo: entranceImageView.centerYAnchor)
        ])
    }
}
