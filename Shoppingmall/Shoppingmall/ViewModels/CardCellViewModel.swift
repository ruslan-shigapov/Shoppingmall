//
//  CardCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 28.08.2024.
//

import UIKit
import Combine

protocol CardCellViewModelProtocol {
    var title: String { get }
    var disclaimer: String { get }
    var imagePublisher: AnyPublisher<UIImage?, Never> { get }
}

final class CardCellViewModel: CardCellViewModelProtocol {
    
    private let card: Card
    
    private var subscription: AnyCancellable?
    
    @Published private var image: UIImage?
    
    var title: String {
        card.title ?? card.name ?? ""
    }
    
    var disclaimer: String {
        card.disclaimer ?? ""
    }
    
    var imagePublisher: AnyPublisher<UIImage?, Never> {
        $image.eraseToAnyPublisher()
    }
    
    init(card: Card) {
        self.card = card
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: card.logoUrl) else { return }
        subscription?.cancel()
        subscription = NetworkManager.shared.publishImage(byUrl: url)
            .receive(on: DispatchQueue.main)
            .catch {
                print($0)
                return Just<UIImage?>(nil)
            }
            .assign(to: \.image, on: self)
    }
}
