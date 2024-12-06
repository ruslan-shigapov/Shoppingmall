//
//  NavigationTableViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 21.11.2024.
//

import UIKit

final class NavigationTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: NavigationTableViewCell.self)
    
    // MARK: Views
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clearGrey
        return view
    }()
    
    private let iconImageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.forwardArrow
        imageView.contentMode = .center
        return imageView
    }()
    
    var viewModel: NavigationCellViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            dividerView.isHidden = viewModel.isFirstBlock
            iconImageView.image = viewModel.icon
            titleLabel.text = viewModel.title
        }
    }

    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .clear
        addSubviews(dividerView, iconImageView, titleLabel, arrowImageView)
        prepareForAutoLayout()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.widthAnchor.constraint(
                equalTo: iconImageView.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 18),
            arrowImageView.widthAnchor.constraint(
                equalTo: arrowImageView.heightAnchor)
        ])
    }
}
