//
//  Shop.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 05.09.2024.
//

struct Shop: Decodable {
    var id: String
    var name: String
    var logoUrl: String
    var floor: Int?
    var siteUrl: String?
    var description: String?
}
