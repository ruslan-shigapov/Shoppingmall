//
//  MapViewController.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 06.12.2024.
//

import WebKit

final class MapViewController: UIViewController {
    
    private let mapWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMap()
    }

    private func setupUI() {
        view.addSubview(mapWebView)
        view.prepareForAutoLayout()
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapWebView.topAnchor.constraint(equalTo: view.topAnchor),
            mapWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadMap() {
        if let url = URL(string: "https://yandex.ru/maps") {
            let request = URLRequest(url: url)
            mapWebView.load(request)
        }
    }
}
