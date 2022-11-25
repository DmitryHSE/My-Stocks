//
//  StockImageHandler.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit

final class StockDetailsLoader {
    
    private let dataFetcherService = DataFetcherService()
    
    func fethStockImagesUrls(tikersArray: [String], completion: @escaping (Int, StockDetailsModel?) -> Void ) {
        for (index, item) in tikersArray.enumerated() {
            dataFetcherService.fetchStockDetailsData(stockName: item) { data in
                guard let decodedData = data else {
                    completion(index, nil)
                    return}
                completion(index,decodedData)
            }
        }
    }
    
    func fethStockDetailsArray(tikersArray: [String], completion: @escaping (Int, [StockDetailsModel]?) -> Void ) {
        var stockDetailsArray = Array(repeating: StockDetailsModel(), count: tikersArray.count)
        let group = DispatchGroup()
        for (index, item) in tikersArray.enumerated() {
            group.enter()
            dataFetcherService.fetchStockDetailsData(stockName: item) { data in
                guard let decodedData = data else {
                    completion(index, nil)
                    return}
                stockDetailsArray[index] = decodedData
                group.leave()
            }
            group.notify(queue: .main) {
                completion(index, stockDetailsArray)
            }
        }
    }
}
