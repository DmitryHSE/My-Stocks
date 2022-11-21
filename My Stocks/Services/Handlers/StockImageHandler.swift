//
//  StockImageHandler.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit
import SVGKit

class StockImageHandler {
    
    private let dataFetcherService = DataFetcherService()
    
    func fethStockImage(tikersArray: [String], completion: @escaping (Int, StockDetailsModel?) -> Void ) {
        for (index, item) in tikersArray.enumerated() {
            dataFetcherService.fetchStockDetailsData(stockName: item) { data in
                guard let decodedData = data else {
                    completion(index, nil)
                    return}
                completion(index,decodedData)
            }
        }
    }
    
    func fetchSVGImage(urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        let svg = SVGKImage(contentsOf: url)
        return svg?.uiImage
    }
    
}
