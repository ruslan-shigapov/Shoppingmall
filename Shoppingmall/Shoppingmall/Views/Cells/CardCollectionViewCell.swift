//
//  CardCollectionViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 19.08.2024.
//

import UIKit
import Combine

final class CardCollectionViewCell: UICollectionViewCell {
    
    static var identifier = String(describing: CardCollectionViewCell.self)
    
    // MARK: Private Properties
    private var storage: Set<AnyCancellable> = []
    
    // MARK: Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let disclaimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [titleLabel, disclaimerLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.addSubview(labelStackView)
        imageView.prepareForAutoLayout()
        return imageView
    }()
    
    // MARK: Public Properties
    var viewModel: CardCellViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            titleLabel.text = viewModel.title
            disclaimerLabel.text = viewModel.disclaimer
            if viewModel.disclaimer.isEmpty {
                labelStackView.removeArrangedSubview(disclaimerLabel)
            }
            viewModel.imagePublisher
                .sink { [weak self] in
                    guard let self else { return }
                    backgroundImageView.image = $0
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
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        addSubview(backgroundImageView)
        prepareForAutoLayout()
    }
}

// MARK: - Layout
private extension CardCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            
            labelStackView.leadingAnchor.constraint(
                equalTo: backgroundImageView.leadingAnchor,
                constant: 16),
            labelStackView.bottomAnchor.constraint(
                equalTo: backgroundImageView.bottomAnchor,
                constant: -16),
            labelStackView.trailingAnchor.constraint(
                equalTo: backgroundImageView.trailingAnchor,
                constant: -16)
        ])
    }
}
