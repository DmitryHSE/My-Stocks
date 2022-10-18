//
//  DataModel.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import Foundation

struct DataModel: Codable {
    let c: Double
    let d: Double
    let dp: Double
    
}

struct StockModel {
    var stockName: String
    let currentPrice: Double
    let priceChange: Double
    let percentChange: Double
    
    init(datamodel: DataModel) {
        self.currentPrice = datamodel.c
        self.priceChange = datamodel.d
        self.percentChange = datamodel.dp
        self.stockName = ""
    }
}
