//
//  ShopCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 05.09.2024.
//

import UIKit
import Combine

protocol ShopCellViewModelProtocol {
    var name: String  { get }
    var imagePublisher: AnyPublisher<UIImage?, Never> { get }
}

final class ShopCellViewModel: ShopCellViewModelProtocol {
    
    private let shop: Shop
    
    private var subscription: AnyCancellable?
    
    @Published private var previewImage: UIImage?
    
    var name: String {
        shop.name
    }
    
    var imagePublisher: AnyPublisher<UIImage?, Never> {
        $previewImage.eraseToAnyPublisher()
    }
    
    init(object: Shop) {
        self.shop = object
        loadImage()
    }
    
    private func loadImage() {
        subscription?.cancel()
        guard let url = URL(string: shop.logoUrl) else { return }
        subscription = NetworkManager.shared.publishImage(byUrl: url)
            .receive(on: DispatchQueue.main)
            .catch {
                print($0)
                return Just<UIImage?>(nil)
            }
            .assign(to: \.previewImage, on: self)
    }
}
