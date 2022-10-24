//
//  StockDetailsModel.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

struct StockDetailsModel: Codable {
    let name: String
    let country: String
    let currency: String
    let finnhubIndustry: String
    let logo : String
    let marketCapitalization: Double
}
