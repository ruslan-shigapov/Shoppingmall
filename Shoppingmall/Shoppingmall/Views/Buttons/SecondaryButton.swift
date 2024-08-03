//
//  SecondaryButton.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.08.2024.
//

import UIKit

final class SecondaryButton: UIButton {

    init(color: UIColor) {
        super.init(frame: .zero)
        setTitleColor(color, for: .normal)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel?.font = UIFont(name: Constants.Fonts.medium, size: 14)
    }
}
