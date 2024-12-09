//
//  StarButton.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 09.12.2024.
//

import UIKit

final class StarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tintColor = .deepBlue
        setImage(UIImage(systemName: "star"), for: .normal)
        setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
}
