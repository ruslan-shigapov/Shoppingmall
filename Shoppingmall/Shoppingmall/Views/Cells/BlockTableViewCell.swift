//
//  BlockTableViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

import UIKit

final class BlockTableViewCell: UITableViewCell {
    
    // MARK: Views
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.medium, size: 18)
        return label
    }()
    
    private let allButton: SecondaryButton = {
        let button = SecondaryButton(color: .deepBlue)
        button.setTitle(Constants.Texts.ButtonTitles.all, for: .normal)
        return button
    }()
    
    private let itemScrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .lightGray
        return scrollView
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
        addSubviews(dividerView, titleLabel, allButton, itemScrollView)
        prepareForAutoLayout()
        setConstraints()
    }
}

// MARK: - Layout
private extension BlockTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: -8),
            dividerView.trailingAnchor.constraint(
                equalTo: allButton.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            allButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            allButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24),
            allButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            itemScrollView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8),
            itemScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemScrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16),
            itemScrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
