//
//  PlaceholderData.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/21/20.
//

import Foundation


struct Placeholder : Identifiable, Codable, Hashable {
    
    var id: Int
    var symbol: String
    var name: String
    var price: Float
    var change: Float
    var image : String
}

let placeholderList: [Placeholder] = [

    .init(id: 1, symbol: "APPL", name: "Apple",price: 420.67, change: 0.71, image: "lukestock"),
    .init(id: 2, symbol: "TSLA", name: "Tesla",price: 600.21, change: 1.34, image: "lukestock"),
//    .init(id: 3, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56, image: "lukestock"),
//    .init(id: 4, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56, image: "lukestock"),
//    .init(id: 5, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56, image: "lukestock"),
//    .init(id: 6, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56, image: "lukestock"),
//    .init(id: 7, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56, image: "lukestock"),
]
