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
        label.textColor = .black
        return label
    }()

    init(title: String, fontSize: CGFloat = 24) {
        titleLabel.text = title
        titleLabel.font = UIFont(name: Constants.Fonts.medium, size: fontSize)
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
        if titleLabel.text == Constants.Texts.TabBarTitles.bonus ||
           titleLabel.text == Constants.Texts.TabBarTitles.menu {
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 6).isActive = true
        } else {
            titleLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor).isActive = true
        }
    }
}
