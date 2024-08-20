//
//  BlockTableViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

import UIKit

final class BlockTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: BlockTableViewCell.self)
    
    // MARK: Views
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let showAllCardsButton: SecondaryButton = {
        let button = SecondaryButton(color: .deepBlue)
        button.setTitle(Constants.Texts.ButtonTitles.all, for: .normal)
        return button
    }()
    
    private lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: Public Properties
    var viewModel: BlockCellViewModelProtocol? {
        didSet {
            guard let viewModel else { return }
            if viewModel.isFirstBlock {
                dividerView.isHidden = true
            }
            titleLabel.text = viewModel.title
            viewModel.fetchCards { [weak self] in
                guard let self else { return }
                cardCollectionView.reloadData()
            }
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
        contentView.addSubviews(
            dividerView,
            titleLabel,
            showAllCardsButton,
            cardCollectionView)
        contentView.prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BlockTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let viewModel else { return .zero }
        // TODO: add right inset
        return CGSize(
            width: viewModel.isFirstBlock ? 334 : 227,
            height: cardCollectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDataSource
extension BlockTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel?.getNumberOfItems() ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath)
        let itemCell = cell as? CardCollectionViewCell
        return itemCell ?? UICollectionViewCell()
    }
}

// MARK: - Layout
extension BlockTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: -8),
            dividerView.trailingAnchor.constraint(
                equalTo: showAllCardsButton.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            showAllCardsButton.bottomAnchor.constraint(
                equalTo: titleLabel.bottomAnchor),
            showAllCardsButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            showAllCardsButton.heightAnchor.constraint(
                equalTo: titleLabel.heightAnchor),
            
            cardCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            cardCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            cardCollectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16),
            cardCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
}
