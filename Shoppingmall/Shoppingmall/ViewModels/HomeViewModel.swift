//
//  HomeViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import Foundation

protocol BlockCellViewModelDelegate {
    func removeEmptyBlock(title: Constants.Texts.BlockTitles)
}

protocol HomeViewModelProtocol: BlockCellViewModelDelegate {
    var wasEmptyBlockDetected: (() -> Void)? { get set }
    func getGreetingText() -> String
    func getNumberOfRows() -> Int
    func getBlockCellViewModel(
        at indexPath: IndexPath
    ) -> BlockCellViewModelProtocol
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private var blockTitles = Constants.Texts.BlockTitles.allCases {
        didSet {
            wasEmptyBlockDetected?()
        }
    }
    
    var wasEmptyBlockDetected: (() -> Void)?
    
    func removeEmptyBlock(title: Constants.Texts.BlockTitles) {
        if let index = blockTitles.firstIndex(of: title) {
            blockTitles.remove(at: index)
        }
    }
        
    func getGreetingText() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 6..<12:
            return Constants.Texts.Greetings.goodMorning
        case 12..<18:
            return Constants.Texts.Greetings.goodAfternoon
        case 18..<24:
            return Constants.Texts.Greetings.goodEvening
        default: break
        }
        return Constants.Texts.Greetings.goodNight
    }
    
    func getNumberOfRows() -> Int {
        blockTitles.count
    }
    
    func getBlockCellViewModel(
        at indexPath: IndexPath
    ) -> BlockCellViewModelProtocol {
        let viewModel = BlockCellViewModel(
            blockTitle: blockTitles[indexPath.row])
        viewModel.delegate = self as BlockCellViewModelDelegate
        return viewModel
    }
}
