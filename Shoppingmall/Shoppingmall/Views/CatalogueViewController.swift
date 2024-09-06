//
//  CatalogueViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 31.08.2024.
//

import UIKit
import Combine

final class CatalogueViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: CatalogueViewModelProtocol
    
    // MARK: Views
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.TabBarTitles.catalogue)
    
    private let pathLabel = UILabel()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: Initialize
    init(viewModel: CatalogueViewModelProtocol) {
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
    }
    
    // MARK: Private Methods 
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubviews(pathLabel, categoryCollectionView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        let navigationBar = navigationController?.navigationBar
        navigationBar?.standardAppearance = navigationBarAppearance
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatalogueViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let categoryVC = ScreenFactory.getCategoryViewController(
            category: viewModel.getCategory(at: indexPath))
        navigationController?.pushViewController(categoryVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CatalogueViewController: UICollectionViewDataSource {
    
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
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath)
        let categoryCell = cell as? CategoryCollectionViewCell
        categoryCell?.configure(
            withTitle: viewModel.getTitleForItem(at: indexPath))
        return categoryCell ?? UICollectionViewCell()
    }
}

// MARK: - Layout
extension CatalogueViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pathLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            pathLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryCollectionView.topAnchor.constraint(
                equalTo: pathLabel.bottomAnchor,
                constant: 8),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            categoryCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            categoryCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
