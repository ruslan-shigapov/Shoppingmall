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
    
    private let showAllItemsButton: SecondaryButton = {
        let button = SecondaryButton(color: .deepBlue)
        button.setTitle(Constants.Texts.ButtonTitles.all, for: .normal)
        return button
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
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
            ItemCollectionViewCell.self,
            forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
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
            showAllItemsButton,
            itemCollectionView)
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
        return CGSize(
            width: viewModel.isFirstBlock ? 334 : 227,
            height: itemCollectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDataSource
extension BlockTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCollectionViewCell.identifier,
            for: indexPath)
        let itemCell = cell as? ItemCollectionViewCell
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
                equalTo: showAllItemsButton.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            showAllItemsButton.bottomAnchor.constraint(
                equalTo: titleLabel.bottomAnchor),
            showAllItemsButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            showAllItemsButton.heightAnchor.constraint(
                equalTo: titleLabel.heightAnchor),
            
            itemCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            itemCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            itemCollectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16),
            itemCollectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor)
        ])
    }
}
