//
//  NavigationCellViewModel.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 21.11.2024.
//

import UIKit

protocol NavigationCellViewModelProtocol {
    var isFirstBlock: Bool { get set }
    var icon: UIImage { get }
    var title: String { get }
}

final class NavigationCellViewModel: NavigationCellViewModelProtocol {
    
    var isFirstBlock: Bool = false
    
    var icon: UIImage
    
    var title: String
    
    init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
}
