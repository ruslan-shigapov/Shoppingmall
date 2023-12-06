//
//  LogoTitleView.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2023.
//

import UIKit

final class LogoTitleView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Images.logo)
        imageView.frame = .init(
            origin: .zero, 
            size: CGSize(width: 120, height: 20)
        )
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
        addSubview(imageView)
        imageView.center.x = center.x
        imageView.center.y = center.y
    }
}
