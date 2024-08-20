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
        Constants.Texts.BlockTitles.allCases.count
    }
    
    func getBlockCellViewModel(
        at indexPath: IndexPath
    ) -> BlockCellViewModelProtocol {
        BlockCellViewModel(
            blockTitle: Constants.Texts.BlockTitles.allCases[indexPath.row])
    }
}
