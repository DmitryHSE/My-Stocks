//
//  DataModel.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation


struct SearchStocksModel: Codable {
    let count: Int
    let result: [Stocks]
}

struct Stocks: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String?
}

struct StockForSearchCell {
    var name: String = ""
    var ticker: String = ""
    var type: String = ""
    var didAddToList: Bool = false
    
    init?(stock: Stocks) {
        name = stock.description
        ticker = stock.symbol
        type = stock.type ?? "n/a"
        didAddToList = false
    }
    
    init() {
        
    }
}
