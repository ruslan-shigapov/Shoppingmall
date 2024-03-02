//
//  PrimaryButton.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 14.02.2024.
//

import UIKit

final class PrimaryButton: UIButton {

    init(
        color: UIColor,
        title: String?,
        titleColor: UIColor = .white,
        titleSize: CGFloat = 14,
        height: CGFloat = 31
    ) {
        super.init(frame: .zero)
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: titleSize, weight: .medium)
        heightAnchor.constraint(equalToConstant: height).isActive = true
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
