//
//  HomeViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 08.08.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    func getGreetingText() -> String
    func getNumberOfRows() -> Int
    func getBlockCellViewModel(
        at indexPath: IndexPath
    ) -> BlockCellViewModelProtocol
}

final class HomeViewModel: HomeViewModelProtocol {
        
    func getGreetingText() -> String {
        return "Добрый день!" // TODO: make logic of finding out time of day
    }
    
    func getNumberOfRows() -> Int {
        Constants.Texts.BlockTitles.allCases.count
    }
    
    func getBlockCellViewModel(
        at indexPath: IndexPath
    ) -> BlockCellViewModelProtocol {
        BlockCellViewModel(
            blockTitle: Constants.Texts.BlockTitles.allCases[indexPath.row])
    }
}
