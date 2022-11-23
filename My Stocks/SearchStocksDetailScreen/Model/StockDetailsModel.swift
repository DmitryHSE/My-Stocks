//
//  StockDetailsModel.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

struct StockDetailsModel: Codable {
    var name: String = ""
    var country: String = ""
    var currency: String = ""
    var finnhubIndustry: String = ""
    var logo : String = ""
    var marketCapitalization: Double = 0.0
    
}
