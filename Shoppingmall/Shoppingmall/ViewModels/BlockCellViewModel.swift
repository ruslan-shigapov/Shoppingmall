//
//  BlockCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

import Foundation
import Combine

protocol BlockCellViewModelProtocol {
    var isFirstBlock: Bool { get }
    var title: String { get }
    func fetchCards(completion: @escaping () -> Void)
    func getNumberOfItems() -> Int
    func getCardCellViewModel(
        at indexPath: IndexPath
    ) -> CardCellViewModelProtocol
}

final class BlockCellViewModel: BlockCellViewModelProtocol {
    
    private let blockTitle: Constants.Texts.BlockTitles
    
    private var subscription: AnyCancellable?
        
    private var cards: [Card] = [] {
        didSet {
            if cards.isEmpty {
                delegate?.removeEmptyBlock(title: blockTitle)
            }
        }
    }
        
    var delegate: BlockCellViewModelDelegate?
    
    var isFirstBlock: Bool {
        blockTitle == .news
    }
    
    var title: String {
        blockTitle.rawValue
    }
    
    init(blockTitle: Constants.Texts.BlockTitles) {
        self.blockTitle = blockTitle
    }
        
    func fetchCards(completion: @escaping () -> Void) {
        subscription = NetworkManager.shared.publishCards(forBlock: blockTitle)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
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
    
    func getCardCellViewModel(
        at indexPath: IndexPath
    ) -> CardCellViewModelProtocol {
        CardCellViewModel(card: cards[indexPath.item])
    }
}
