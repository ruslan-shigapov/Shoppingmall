//
//  CategoryViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 04.09.2024.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: CategoryViewModelProtocol
    
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Constants.Texts.searchPlaceholder
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.Texts.searchPlaceholder,
            attributes: [.foregroundColor : UIColor.clearGrey])
        searchBar.searchTextField.leftView?.tintColor = .clearGrey
        searchBar.searchTextField.textColor = .black
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var shopTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(
            ShopTableViewCell.self,
            forCellReuseIdentifier: ShopTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
        
    private let noShopsStackView: UIStackView = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: Constants.Fonts.regular, size: 18)
        descriptionLabel.textColor = .clearGrey
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = Constants.Texts.noResults
        descriptionLabel.numberOfLines = 4
        let illustrationImageView = UIImageView(
            image: Constants.Images.illustration)
        let stackView = UIStackView(
            arrangedSubviews: [descriptionLabel, illustrationImageView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.isHidden = true
        return stackView
    }()

    // MARK: Initialize
    init(viewModel: CategoryViewModelProtocol) {
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
        setupContent()
        addHideKeyboardGesture()
    }
    
    // MARK: Private Methods 
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleView
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(searchBar, shopTableView, noShopsStackView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupContent() {
        viewModel.fetchShops { [weak self] in
            guard let self else { return }
            updateUI()
        }
    }
    
    private func addHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func updateUI() {
        shopTableView.reloadData()
        noShopsStackView.isHidden = viewModel.numberOfRows() != 0
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        60
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        let shopVC = ScreenFactory.getShopDetailsViewController(
            shop: viewModel.getShop(at: indexPath))
        navigationController?.pushViewController(shopVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ShopTableViewCell.identifier)
        let shopCell = cell as? ShopTableViewCell
        shopCell?.isFirstObject = indexPath.row == 0
        shopCell?.viewModel = viewModel.getShopCellViewModel(at: indexPath)
        return shopCell ?? UITableViewCell()
    }
}

// MARK: - UISearchBarDelegate
extension CategoryViewController: UISearchBarDelegate {
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        viewModel.search(byText: searchText) { [weak self] in
            guard let self else { return }
            updateUI()
        }
    }
}

// MARK: - Layout
extension CategoryViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 18),
            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -18),
            
            shopTableView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 40),
            shopTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            shopTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            shopTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            noShopsStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            noShopsStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor)
        ])
    }
}
