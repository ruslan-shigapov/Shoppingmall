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
    func fetchObjects(completion: @escaping () -> Void)
    func getObjectCellViewModel(
        at indexPath: IndexPath
    ) -> ObjectCellViewModelProtocol
    func search(byText searchText: String, completion: @escaping () -> Void)
}

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let category: Category
    
    private var subscription: AnyCancellable?
    
    private var objects: [Object] = [] {
        didSet {
            filteredObjects = objects
        }
    }
    
    private var filteredObjects: [Object] = []
    
    var title: String {
        category.name
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func fetchObjects(completion: @escaping () -> Void) {
        subscription = NetworkManager.shared.publishObjects(for: category.slug)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                    objects = []
                    completion()
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                objects = $0
                completion()
            }
    }
    
    func numberOfRows() -> Int {
        filteredObjects.count
    }
    
    func getObjectCellViewModel(
        at indexPath: IndexPath
    ) -> ObjectCellViewModelProtocol {
        ObjectCellViewModel(object: filteredObjects[indexPath.row])
    }
    
    func search(byText searchText: String, completion: @escaping () -> Void) {
        filteredObjects = searchText.isEmpty ? objects : objects.filter { $0.name.lowercased().contains(searchText.lowercased())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion()
        }
    }
}
