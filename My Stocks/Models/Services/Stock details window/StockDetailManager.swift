//
//  StockDetailManager.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

struct StockDetailManager {
    func performRequest(stockName: String, completion: @escaping (_ stockDetails: StockDetailsModel?) -> ()) {
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    guard let stockDetails = decodeJson(stockName: stockName, safeData) else {return}
                    completion(stockDetails)
                }
            }
            task.resume()
        }
    }
    
    
    private func decodeJson(stockName: String, _ data: Data) -> StockDetailsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(StockDetailsModel.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
