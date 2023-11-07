//
//  AuthViewController.swift
//  Shoppingmall
//
//  Created by Руслан Шигапов on 01.11.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var signLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите номер телефона"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 14, weight: .light)
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        view.addSubview(textField)
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "На него будет отправлен одноразовый код"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "DeepBlue")
        button.layer.cornerRadius = 8
        button.setTitle("Готово", for: .normal)
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
        view.addSubview(titleLabel)
        view.addSubview(signLabel)
        view.addSubview(backgroundView)
        view.addSubview(infoLabel)
        view.addSubview(doneButton)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor ,
                constant: 40
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),
            signLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            
            backgroundView.topAnchor.constraint(
                equalTo: signLabel.bottomAnchor,
                constant: 16
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            backgroundView.heightAnchor.constraint(equalToConstant: 31),
            
            textField.leadingAnchor.constraint(
                equalTo: backgroundView.leadingAnchor,
                constant: 16
            ),
            textField.trailingAnchor.constraint(
                equalTo: backgroundView.trailingAnchor,
                constant: -16
            ),
            textField.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: 8
            ),
            textField.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -8
            ),
            
            infoLabel.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: 8
            ),
            infoLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            doneButton.topAnchor.constraint(
                equalTo: infoLabel.bottomAnchor,
                constant: 40
            ),
            doneButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            doneButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),
            doneButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
}

