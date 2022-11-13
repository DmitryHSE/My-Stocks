//
//  SearchedStocksDataHandler.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

class SearchedStocksDataHandler {
    private let dataFetcherService = DataFetcherService()

    func getStockSearchingResults(text: String, completion: @escaping ([StockForSearchCell]) -> Void ) {
        dataFetcherService.fetchStockDataForSearchRequest(stockName: text) { stocksArray in
            var array = [StockForSearchCell]()
            guard let stocksArray = stocksArray else { return }

            for i in stocksArray.result {
                array.append(StockForSearchCell(stock: i)!)
            }
            completion(array)
        }
    }
}



