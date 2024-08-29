//
//  BlockCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

import Foundation

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
        NetworkManager.shared.fetchCards(
            forBlock: blockTitle
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let cards):
                self.cards = cards
                completion()
            case .failure(let error):
                cards = []
                print(error)
            }
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
