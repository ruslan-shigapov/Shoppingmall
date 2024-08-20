//
//  CardCollectionViewCell.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 19.08.2024.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    static var identifier = String(describing: CardCollectionViewCell.self)
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .lightGray
        layer.cornerRadius = 12
    }
}
