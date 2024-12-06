//
//  ShopDetailsViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 07.09.2024.
//

import UIKit
import Combine

final class ShopDetailsViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: ShopDetailsViewModelProtocol
    
    // MARK: Private Properties
    private var storage: Set<AnyCancellable> = []
    
    // MARK: Views
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Constants.Images.backArrow,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        button.tintColor = .deepBlue
        return button
    }()
    
    private lazy var titleView = NavigationBarTitleView(
        title: viewModel.title,
        fontSize: 16)
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clearGrey
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let floorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 18)
        label.textColor = .deepBlue
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [floorLabel, websiteLabel])
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    private let locationButton: PrimaryButton = {
        let button = PrimaryButton(color: .deepBlue)
        button.setTitle(Constants.Texts.ButtonTitles.location, for: .normal)
        button.setImage(Constants.Images.whitePin, for: .normal)
        button.setImage(Constants.Images.whitePin, for: .highlighted)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var blockTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(
            BlockTableViewCell.self,
            forCellReuseIdentifier: BlockTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [blockTableView, descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubviews(
            logoImageView,
            infoStackView,
            locationButton,
            detailsStackView)
        scrollView.prepareForAutoLayout()
        return scrollView
    }()
    
    // MARK: Initialize
    init(viewModel: ShopDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        bind()
        setupContent()
        handleEvents()
    }
    
    // MARK: Private Methods
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleView
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(verticalScrollView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func bind() {
        viewModel.imagePublisher
            .sink { [weak self] in
                guard let self else { return }
                logoImageView.image = $0
            }
            .store(in: &storage)
    }
    
    private func setupContent() {
        viewModel.fetchShopDetails { [weak self] in
            guard let self else { return }
            floorLabel.text = viewModel.floor
            websiteLabel.text = viewModel.website
            descriptionLabel.text = viewModel.description
        }
    }
    
    private func handleEvents() {
        viewModel.wasEmptyBlockDetected = { [weak self] in
            guard let self else { return }
            detailsStackView.removeArrangedSubview(blockTableView)
            blockTableView.removeFromSuperview()
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ShopDetailsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        187
    }
}

// MARK: - UITableViewDataSource
extension ShopDetailsViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BlockTableViewCell.identifier)
        let blockCell = cell as? BlockTableViewCell
        blockCell?.viewModel = viewModel.getBlockCellViewModel()
        return blockCell ?? UITableViewCell()
    }
}

// MARK: - Layout 
extension ShopDetailsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalScrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            verticalScrollView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            verticalScrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            logoImageView.topAnchor.constraint(
                equalTo: verticalScrollView.topAnchor,
                constant: 24),
            logoImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            logoImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            logoImageView.heightAnchor.constraint(equalToConstant: 240),
            
            infoStackView.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 16),
            infoStackView.leadingAnchor.constraint(
                equalTo: logoImageView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(
                equalTo: logoImageView.trailingAnchor),
            
            locationButton.topAnchor.constraint(
                equalTo: infoStackView.bottomAnchor,
                constant: 24),
            locationButton.leadingAnchor.constraint(
                equalTo: logoImageView.leadingAnchor),
            locationButton.trailingAnchor.constraint(
                equalTo: logoImageView.trailingAnchor),
            
            detailsStackView.topAnchor.constraint(
                equalTo: locationButton.bottomAnchor,
                constant: 24),
            detailsStackView.leadingAnchor.constraint(
                equalTo: logoImageView.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(
                equalTo: logoImageView.trailingAnchor),
            detailsStackView.bottomAnchor.constraint(
                equalTo: verticalScrollView.bottomAnchor,
                constant: -24),
            
            blockTableView.heightAnchor.constraint(equalToConstant: 187)
        ])
    }
}
