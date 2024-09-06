//
//  CategoryCollectionViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 03.09.2024.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static var identifier = String(describing: CategoryCollectionViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let colors: [UIColor] = [.deepBlue, .milkyPink, .smokyBlack, .lightGray]
        backgroundColor = colors.randomElement()
        layer.cornerRadius = 12
        addSubview(titleLabel)
        prepareForAutoLayout()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: bounds.width)
        ])
    }
    
    func configure(withTitle title: String) {
        titleLabel.text = title
    }
}
