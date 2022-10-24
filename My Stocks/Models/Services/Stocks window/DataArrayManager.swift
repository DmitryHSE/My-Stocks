//
//  DataArrayManager.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import Foundation

let dataManager = DataManager()

func getStocksArray(tikersArray: [String], completion: @escaping (Int, StockModel) -> Void ) {
    for (index, item) in tikersArray.enumerated() {
        dataManager.performRequest(stockName: item) { stock in
            completion(index,stock)
        }
    }
}
