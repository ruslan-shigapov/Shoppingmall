//
//  ObjectTableViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 05.09.2024.
//

import UIKit
import Combine

final class ObjectTableViewCell: UITableViewCell {
    
    static var identifier = String(describing: ObjectTableViewCell.self)
    
    // MARK: Private Properties
    private var storage: Set<AnyCancellable> = []
    
    // MARK: Views
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.pin
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Properties 
    var isFirstObject = false
    
    var viewModel: ObjectCellViewModelProtocol? {
        didSet {
            titleLabel.text = viewModel?.name
            viewModel?.imagePublisher
                .sink { [weak self] in
                    guard let self else { return }
                    previewImageView.image = $0
                }
                .store(in: &storage)
        }
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        dividerView.isHidden = isFirstObject
        setConstraints()
    }

    // MARK: Private Methods
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubviews(
            dividerView,
            previewImageView,
            titleLabel,
            pinImageView)
        contentView.prepareForAutoLayout()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(
                equalTo: previewImageView.topAnchor,
                constant: -8),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 2),
            
            previewImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewImageView.heightAnchor.constraint(equalToConstant: 42),
            previewImageView.widthAnchor.constraint(equalToConstant: 42),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: previewImageView.trailingAnchor,
                constant: 16),
            titleLabel.trailingAnchor.constraint(
                equalTo: pinImageView.leadingAnchor,
                constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pinImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8),
            pinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pinImageView.heightAnchor.constraint(equalToConstant: 18),
            pinImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
}
