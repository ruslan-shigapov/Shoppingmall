//
//  NewsAndOffersViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 24.11.2024.
//

import Foundation
import Combine

protocol NewsAndOffersViewModelProtocol {
    func fetchCards(completion: @escaping () -> Void)
    func getNumberOfItems() -> Int
    func getBigCardCellViewModel(at index: Int) -> BigCardCellViewModel
}

final class NewsAndOffersViewModel: NewsAndOffersViewModelProtocol {
    
    private var cards: [Card] = []
    
    private var subscription: AnyCancellable?
    
    func fetchCards(completion: @escaping () -> Void) {
        subscription?.cancel()
        subscription = NetworkManager.shared.publishCards(
            forBlock: .news,
            shopId: "")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error)
                    cards = []
                    completion()
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                cards = $0
                completion()
            }
    }
    
    func getNumberOfItems() -> Int {
        cards.count
    }
    
    func getBigCardCellViewModel(at index: Int) -> BigCardCellViewModel {
        BigCardCellViewModel(card: cards[index])
    }
}
