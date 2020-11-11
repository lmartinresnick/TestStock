//
//  SearchPlaceholderData.swift
//  SwiftUITestStock
//
//  Created by Luke Martin-Resnick on 10/29/20.
//

import Foundation

struct SearchPlaceholderData : Identifiable, Codable, Hashable {
    
    var id: Int
    var symbol: String
    var name: String
    var price: Float
    var change: Float
}

let searchPlaceholderDataList: [SearchPlaceholderData] = [

    .init(id: 1, symbol: "APPL", name: "Apple",price: 420.67, change: 0.71),
    .init(id: 2, symbol: "TSLA", name: "Tesla",price: 600.21, change: 1.34),
    .init(id: 3, symbol: "DIS", name: "Disney", price: 324.12, change: 1.56),
    .init(id: 4, symbol: "GOOG", name: "Google", price: 324.12, change: 1.56),
    .init(id: 5, symbol: "MSFT", name: "Microsoft", price: 324.12, change: 1.56),
    .init(id: 6, symbol: "SNAP", name: "Snapchat", price: 324.12, change: 1.56),
    .init(id: 7, symbol: "UBER", name: "Uber", price: 324.12, change: 1.56),
    .init(id: 8, symbol: "TWTR", name: "Twiiter", price: 324.12, change: 1.56),
    .init(id: 9, symbol: "AMD", name: "Advanced Micro Devices", price: 324.12, change: 1.56),
    .init(id: 10, symbol: "FB", name: "Facebook", price: 324.12, change: 1.56),
    .init(id: 11, symbol: "UBER", name: "Uber", price: 324.12, change: 1.56),
    .init(id: 12, symbol: "AMAZ", name: "Amazon", price: 324.12, change: 1.56)
]
