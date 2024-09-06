//
//  ObjectCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 05.09.2024.
//

import UIKit
import Combine

protocol ObjectCellViewModelProtocol {
    var name: String  { get }
    var imagePublisher: AnyPublisher<UIImage?, Never> { get }
}

final class ObjectCellViewModel: ObjectCellViewModelProtocol {
    
    private let object: Object
    
    private var subscription: AnyCancellable?
    
    @Published private var previewImage: UIImage?
    
    var name: String {
        object.name
    }
    
    var imagePublisher: AnyPublisher<UIImage?, Never> {
        $previewImage.eraseToAnyPublisher()
    }
    
    init(object: Object) {
        self.object = object
        loadImage()
    }
    
    private func loadImage() {
        guard let url = URL(string: object.logoUrl) else { return }
        subscription = NetworkManager.shared.publishImage(byUrl: url)
            .receive(on: DispatchQueue.main)
            .catch {
                print($0.localizedDescription)
                return Just<UIImage?>(nil)
            }
            .assign(to: \.previewImage, on: self)
    }
}
