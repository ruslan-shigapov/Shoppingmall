//
//  BlockCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

protocol BlockCellViewModelProtocol {
    var isFirstBlock: Bool { get }
    var title: String { get }
    func fetchCards(completion: @escaping () -> Void)
    func getNumberOfItems() -> Int
}

final class BlockCellViewModel: BlockCellViewModelProtocol {
    
    private let blockTitle: Constants.Texts.BlockTitles
    
    private var cards: [Card] = []
    
    var isFirstBlock: Bool {
        blockTitle == Constants.Texts.BlockTitles.news
    }
    
    var title: String {
        blockTitle.rawValue
    }
    
    init(blockTitle: Constants.Texts.BlockTitles) {
        self.blockTitle = blockTitle
    }
    
    func fetchCards(completion: @escaping () -> Void) {
        if isFirstBlock {
            NetworkManager.shared.fetchCards { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let cards):
                    self.cards = cards
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getNumberOfItems() -> Int {
        cards.count
    }
}
