//
//  OrdinaryButton.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2023.
//

import UIKit

class OrdinaryButton: UIButton {

    init(color: UIColor, title: String?, titleColor: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 8
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLabel?.font = .systemFont(ofSize: 14)
    }
}
