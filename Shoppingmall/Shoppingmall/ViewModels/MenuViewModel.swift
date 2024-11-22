//
//  MenuViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 22.11.2024.
//

import UIKit

protocol MenuViewModelProtocol {
    func getNumberOfRows() -> Int
    func getNavigationCellViewModel(
        at index: Int
    ) -> NavigationCellViewModelProtocol
}

final class MenuViewModel: MenuViewModelProtocol {
    
    func getNumberOfRows() -> Int {
        6
    }
    
    func getNavigationCellViewModel(
        at index: Int
    ) -> NavigationCellViewModelProtocol {
        let menuIconNames = Constants.Texts.MenuIconNames.allCases
        return NavigationCellViewModel(
            icon: UIImage(named: menuIconNames[index].rawValue)!,
            title: Constants.Texts.MenuTitles.allCases[index].rawValue)
    }
}
