//
//  LogoView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 02.03.2024.
//

import UIKit

final class LogoView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Images.logo)
        imageView.frame = .init(x: 0, y: 0, width: 120, height: 18)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(logoImageView)
        logoImageView.center.x = center.x
        logoImageView.center.y = center.y
    }
}
