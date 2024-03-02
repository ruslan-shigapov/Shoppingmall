//
//  HomeViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 30.01.2024.
//

import UIKit

final class HomeViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
