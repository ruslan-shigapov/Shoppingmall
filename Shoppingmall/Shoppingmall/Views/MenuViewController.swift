//
//  MenuViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 31.08.2024.
//

import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: Private Properties
    private let viewModel: MenuViewModelProtocol
    
    // MARK: Views
    private let titleView = NavigationBarTitleView(
        title: Constants.Texts.TabBarTitles.menu)
    
    private lazy var headerStackView: UIStackView = {
        let firstLabel = UILabel()
        firstLabel.text = "O"
        firstLabel.textColor = .black
        firstLabel.font = UIFont(name: Constants.Fonts.regular, size: 18)
        let secondLabel = UILabel()
        secondLabel.text = Constants.Texts.appName
        secondLabel.textColor = .black
        secondLabel.font = UIFont(name: Constants.Fonts.medium, size: 18)
        let stackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var navigationTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(
            NavigationTableViewCell.self,
            forCellReuseIdentifier: NavigationTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Initialize
    init(viewModel: MenuViewModelProtocol) {
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
        view.addSubviews(headerStackView, navigationTableView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        50
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0: navigationController?.pushViewController(
            ScreenFactory.getNewsAndOffersViewController(),
            animated: true)
        case 1: navigationController?.pushViewController(
            ScreenFactory.getHowToGetViewController(),
            animated: true)
        case 2: break
        case 3: break
        case 4: navigationController?.pushViewController(
            ScreenFactory.getSettingViewController(),
            animated: true)
        case 5: break
        default: break
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
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
            withIdentifier: NavigationTableViewCell.identifier)
        let navigationCell = cell as? NavigationTableViewCell
        navigationCell?.viewModel = viewModel.getNavigationCellViewModel(
            at: indexPath.row)
        navigationCell?.viewModel?.isFirstBlock = indexPath.row == 0
        return navigationCell ?? UITableViewCell()
    }
}

// MARK: - Layout
extension MenuViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            headerStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            
            navigationTableView.topAnchor.constraint(
                equalTo: headerStackView.bottomAnchor,
                constant: 16),
            navigationTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            navigationTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            navigationTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24)
        ])
    }
}
