//
//  CatalogueViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 31.08.2024.
//

import UIKit

final class CatalogueViewController: UIViewController {

    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.TabBarTitles.catalogue)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
    }
}
