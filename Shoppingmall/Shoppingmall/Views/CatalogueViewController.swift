//
//  CatalogueViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 31.08.2024.
//

import UIKit
import Combine

final class CatalogueViewController: UIViewController {
    
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.TabBarTitles.catalogue)
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubview(categoryCollectionView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.backgroundColor = .white
//        tabBarController?.tabBar.standardAppearance = tabBarAppearance
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            categoryCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            categoryCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}

extension CatalogueViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width / 2 - 8
        return CGSize(width: width, height: width)
    }
}

extension CatalogueViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        7
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath)
        let categoryCell = cell as? CategoryCollectionViewCell
        let colors: [UIColor] = [.deepBlue, .milkyPink, .smokyBlack, .lightGray]
        categoryCell?.backgroundColor = colors.randomElement()
        categoryCell?.layer.cornerRadius = 12
        return categoryCell ?? UICollectionViewCell()
    }
}
