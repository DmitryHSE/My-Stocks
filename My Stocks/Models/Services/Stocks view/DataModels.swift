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
    var stockName: String = ""
    var currentPrice: Double = 0.0
    var priceChange: Double = 0.0
    var percentChange: Double = 0.0
    
    init?(datamodel: DataModel) {
        currentPrice = datamodel.c
        priceChange = datamodel.d
        percentChange = datamodel.dp
        stockName = ""
    }
    
    init() {
        
    }
}
