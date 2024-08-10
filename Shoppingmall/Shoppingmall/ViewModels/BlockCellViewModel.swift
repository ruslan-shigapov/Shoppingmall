//
//  BlockCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 10.08.2024.
//

protocol BlockCellViewModelProtocol {
    var isFirstBlock: Bool { get }
    var title: String { get }
}

final class BlockCellViewModel: BlockCellViewModelProtocol {
    
    private let blockTitle: Constants.Texts.BlockTitles
    
    var isFirstBlock: Bool {
        blockTitle == Constants.Texts.BlockTitles.news
    }
    
    var title: String {
        blockTitle.rawValue
    }
    
    init(blockTitle: Constants.Texts.BlockTitles) {
        self.blockTitle = blockTitle
    }
}
