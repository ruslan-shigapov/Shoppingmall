//
//  CatalogueViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 04.09.2024.
//

import Foundation
import Combine

protocol CatalogueViewModelProtocol {
    func getNumberOfItems() -> Int
    func getTitleForItem(at indexPath: IndexPath) -> String
    func getCategory(at indexPath: IndexPath) -> Category
}

final class CatalogueViewModel: CatalogueViewModelProtocol {
    
    private var subscription: AnyCancellable?
    
    private var categories: [Category] = []
    
    init() {
        fetchCategories()
    }
    
    private func fetchCategories() {
        subscription = NetworkManager.shared.publishCategories()
            .receive(on: DispatchQueue.main)
            .sink {
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                categories = $0
            }
    }
    
    func getNumberOfItems() -> Int {
        categories.count
    }
    
    func getTitleForItem(at indexPath: IndexPath) -> String {
        categories[indexPath.item].name
    }
    
    func getCategory(at indexPath: IndexPath) -> Category {
        categories[indexPath.item]
    }
}
