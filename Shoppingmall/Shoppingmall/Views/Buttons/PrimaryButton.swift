//
//  PrimaryButton.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class PrimaryButton: UIButton {

    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        backgroundColor == .white
        ? setTitleColor(.deepBlue, for: .normal)
        : setTitleColor(.white, for: .normal)
        if backgroundColor == .white || backgroundColor == .smokyBlack {
            titleLabel?.font = UIFont(name: Constants.Fonts.medium, size: 16)
            heightAnchor.constraint(equalToConstant: 34).isActive = true
        } else {
            titleLabel?.font = UIFont(name: Constants.Fonts.medium, size: 14)
            heightAnchor.constraint(equalToConstant: 31).isActive = true
        }
    }
}
