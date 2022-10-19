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
