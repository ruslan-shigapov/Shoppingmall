//
//  HomeViewController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 10.11.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.Images.logo
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Text.afternoon
        label.font = .systemFont(ofSize: 32)
        return label
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
        view.addSubview(titleLabel)
    }
}

// MARK: - Layout Constraints
extension HomeViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor ,
                constant: 40
            ),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 120),
            logoView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(
                equalTo: logoView.bottomAnchor,
                constant: 24
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
