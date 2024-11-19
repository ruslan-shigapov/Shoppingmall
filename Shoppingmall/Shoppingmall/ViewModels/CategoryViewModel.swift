//
//  CategoryViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 04.09.2024.
//

import Foundation
import Combine

protocol CategoryViewModelProtocol {
    var title: String { get }
    func numberOfRows() -> Int
    func fetchShops(completion: @escaping () -> Void)
    func getShopCellViewModel(
        at indexPath: IndexPath
    ) -> ShopCellViewModelProtocol
    func search(byText searchText: String, completion: @escaping () -> Void)
    func getShop(at indexPath: IndexPath) -> Shop
}

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let category: Category
    
    private var subscription: AnyCancellable?
    
    private var shops: [Shop] = [] {
        didSet {
            filteredShops = shops
        }
    }
    
    private var filteredShops: [Shop] = []
    
    var title: String {
        category.name
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func fetchShops(completion: @escaping () -> Void) {
        subscription?.cancel()
        subscription = NetworkManager.shared.publishShops(for: category.slug)
            .receive(on: DispatchQueue.main)
            .sink { 
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                shops = $0
                completion()
            }
    }
    
    func numberOfRows() -> Int {
        filteredShops.count
    }
    
    func getShopCellViewModel(
        at indexPath: IndexPath
    ) -> ShopCellViewModelProtocol {
        ShopCellViewModel(object: filteredShops[indexPath.row])
    }
    
    func search(byText searchText: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            filteredShops = searchText.isEmpty ? shops : shops.filter { $0.name.lowercased().contains(searchText.lowercased())
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getShop(at indexPath: IndexPath) -> Shop {
        shops[indexPath.row]
    }
}
