//
//  ArrayForCellsManager.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

let searchStockManager = SearchStocksManager()

func getSearchedStocks(text: String, completion: @escaping ([StockForSearchCell]) -> Void ) {
    searchStockManager.performRequest(stockName: text) { stocksArray in
        var array = [StockForSearchCell]()
        for i in stocksArray.result {
            array.append(StockForSearchCell(stock: i)!)
        }
        
        completion(array)
    }
}
