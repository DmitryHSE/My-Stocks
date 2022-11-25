//
//  MainStocksListDataHandler.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import Foundation

final class MainStocksListDataHandler {
    
    private let dataFetcherService = DataFetcherService()
    
    func loadStocksList(tikersArray: [String], completion: @escaping (Int, StockModel?) -> Void ) {
        for (index, item) in tikersArray.enumerated() {
            dataFetcherService.fetchStockQuotesData(stockName: item) { data in
                guard let decodedData = data else {
                    completion(index, nil)
                    return}
                var stockModel = StockModel(datamodel: decodedData)
                stockModel?.stockName = item
                completion(index,stockModel)
            }
        }
    }
}



