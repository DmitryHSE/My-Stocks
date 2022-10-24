//
//  DataManager.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import Foundation

struct DataManager {
    
    func performRequest(stockName: String, completion: @escaping (_ stock: StockModel) -> ()) {
        let urlString = "https://finnhub.io/api/v1/quote?symbol=\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data { 
                    guard let stock = decodeJson(stockName: stockName, safeData) else {return}
                    completion(stock)
                }
            }
            task.resume()
        }
    }
    
    
    private func decodeJson(stockName: String, _ data: Data) -> StockModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(DataModel.self, from: data)
            var stockModel = StockModel(datamodel: decodedData)
            stockModel?.stockName = stockName
            return stockModel
        } catch {
            print(error)
            return nil
        }
    }
}
