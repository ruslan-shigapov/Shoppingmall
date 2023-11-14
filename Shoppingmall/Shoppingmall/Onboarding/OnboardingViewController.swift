//
//  OnboardingViewController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 11.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.logo
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.deepBlue
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.shoppingAndRest
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Text.firstPageTitle
        label.font = .systemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4
        return pageControl
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.skip, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(logoView)
        view.addSubview(backgroundView)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
    }
}

// MARK: - Layout Constraints
extension OnboardingViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 120),
            logoView.heightAnchor.constraint(equalToConstant: 20),
            
            backgroundView.topAnchor.constraint(
                equalTo: logoView.bottomAnchor,
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
            
            imageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 200
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

