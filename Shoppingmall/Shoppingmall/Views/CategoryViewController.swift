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
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var objectTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(
            ObjectTableViewCell.self,
            forCellReuseIdentifier: ObjectTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
        
    private let noObjectsStackView: UIStackView = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: Constants.Fonts.regular, size: 18)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = Constants.Texts.noObjects
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
        view.addSubviews(searchBar, objectTableView, noObjectsStackView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupContent() {
        viewModel.fetchObjects { [weak self] in
            guard let self else { return }
            updateUI()
        }
    }
    
    private func addHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func updateUI() {
        objectTableView.reloadData()
        noObjectsStackView.isHidden = viewModel.numberOfRows() != 0
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
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        60
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
            withIdentifier: ObjectTableViewCell.identifier)
        let objectCell = cell as? ObjectTableViewCell
        objectCell?.isFirstObject = indexPath.row == 0
        objectCell?.viewModel = viewModel.getObjectCellViewModel(at: indexPath)
        return objectCell ?? UITableViewCell()
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
            
            objectTableView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 40),
            objectTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            objectTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            objectTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24),
            
            noObjectsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noObjectsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
