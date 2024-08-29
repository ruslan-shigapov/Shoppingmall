//
//  Card.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 20.08.2024.
//

import Foundation

struct Card: Decodable {
    var title: String?
    var name: String?
    var logo_url: String
    var disclaimer: String?
}
