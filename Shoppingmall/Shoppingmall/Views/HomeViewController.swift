//
//  HomeViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: Private Properties
    private var viewModel: HomeViewModelProtocol

    // MARK: Views
    private let titleImageView = UIImageView(image: Constants.Images.appName)
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.regular, size: 32)
        label.textColor = .black
        label.text = viewModel.getGreetingText()
        return label
    }()
    
    private lazy var blockTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(
            BlockTableViewCell.self,
            forCellReuseIdentifier: BlockTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: Initialize
    init(viewModel: HomeViewModelProtocol) {
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
        handleEvents()
    }
    
    // MARK: Private Methods
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = .white
        view.addSubviews(greetingLabel, blockTableView)
        view.prepareForAutoLayout()
        setConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleImageView
    }
    
    private func handleEvents() {
        viewModel.wasEmptyBlockDetected = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.blockTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate 
extension HomeViewController: UITableViewDelegate {
    
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
        indexPath.row == 0 ? 227 : 187
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
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
        blockCell?.viewModel = viewModel.getBlockCellViewModel(at: indexPath)
        return blockCell ?? UITableViewCell()
    }
}

// MARK: - Layout
extension HomeViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleImageView.heightAnchor.constraint(equalToConstant: 18),
            titleImageView.widthAnchor.constraint(equalToConstant: 120),
            
            greetingLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            blockTableView.topAnchor.constraint(
                equalTo: greetingLabel.bottomAnchor,
                constant: 8),
            blockTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24),
            blockTableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24),
            blockTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
}
