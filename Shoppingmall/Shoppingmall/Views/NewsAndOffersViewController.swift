//
//  NewsAndOffersViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 23.11.2024.
//

import UIKit

final class NewsAndOffersViewController: UIViewController {
    
    // MARK: Private Properties
    private let viewModel: NewsAndOffersViewModelProtocol
    
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
    
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.MenuTitles.newsAndOffers.rawValue)
    
    private let pathLabel = UILabel()
    
    private lazy var bigCardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            BigCardCollectionViewCell.self,
            forCellWithReuseIdentifier: BigCardCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: Initialize
    init(viewModel: NewsAndOffersViewModelProtocol) {
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
        setupUI()
        setupContent()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubviews(pathLabel, bigCardCollectionView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleView
    }
    
    private func setupContent() {
        viewModel.fetchCards { [weak self] in
            guard let self else { return }
            bigCardCollectionView.reloadData()
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsAndOffersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: bigCardCollectionView.bounds.width, height: 288)
    }
}

// MARK: - UICollectionViewDataSource
extension NewsAndOffersViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BigCardCollectionViewCell.identifier,
            for: indexPath)
        let bigCardCell = cell as? BigCardCollectionViewCell
        bigCardCell?.viewModel = viewModel.getBigCardCellViewModel(
            at: indexPath.row)
        return bigCardCell ?? UICollectionViewCell()
    }
}

// MARK: - Layout
extension NewsAndOffersViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pathLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            pathLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bigCardCollectionView.topAnchor.constraint(
                equalTo: pathLabel.bottomAnchor,
                constant: 8),
            bigCardCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            bigCardCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            bigCardCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
