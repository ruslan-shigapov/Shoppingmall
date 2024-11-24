//
//  Card.swift
//  Shoppingmall
//
//  Created by Ruslan Shigapov on 20.08.2024.
//

struct Card: Decodable {
    var title: String?
    var name: String?
    var logoUrl: String
    var disclaimer: String?
    var date: Dates?
}

struct Dates: Decodable {
    var start: String
    var finish: String
}
