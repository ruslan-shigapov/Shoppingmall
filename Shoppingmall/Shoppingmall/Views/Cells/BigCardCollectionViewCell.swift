//
//  BigCardCollectionViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 23.11.2024.
//

import UIKit
import Combine

final class BigCardCollectionViewCell: UICollectionViewCell {
    
    static var identifier = String(describing: BigCardCollectionViewCell.self)
    
    // MARK: Private Properties
    private var storage: Set<AnyCancellable> = []
    
    // MARK: Views
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 24)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let datesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 18)
        label.textColor = .black
        return label
    }()
    
    // MARK: Public Properties
    var viewModel: BigCardCellViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            titleLabel.text = viewModel.title
            datesLabel.text = viewModel.dates
            viewModel.imagePublisher
                .sink { [weak self] in
                    guard let self else { return }
                    cardImageView.image = $0
                }
                .store(in: &storage)
        }
    }
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .clearGrey
        addSubviews(cardImageView, titleLabel, datesLabel)
        prepareForAutoLayout()
        layer.cornerRadius = 12
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16),
            cardImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            cardImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            cardImageView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(
                equalTo: cardImageView.bottomAnchor,
                constant: 12),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16),
            
            datesLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            datesLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16),
            datesLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16)
        ])
    }
}
