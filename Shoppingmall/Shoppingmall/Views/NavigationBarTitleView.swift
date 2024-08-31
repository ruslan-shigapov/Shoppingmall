//
//  NavigationBarTitleView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 31.08.2024.
//

import UIKit

final class NavigationBarTitleView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 24)
        label.textColor = .black
        return label
    }()

    init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        prepareForAutoLayout()
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.centerYAnchor.constraint(
            equalTo: centerYAnchor).isActive = true
        if titleLabel.text == Constants.Texts.TabBarTitles.catalogue {
            titleLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor).isActive = true
        } else {
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 6).isActive = true
        }
    }
}
