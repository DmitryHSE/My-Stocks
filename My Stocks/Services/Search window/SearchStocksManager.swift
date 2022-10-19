//
//  SearchStocksManager.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

struct SearchStocksManager {
    
    func performRequest(stockName: String, completion: @escaping (_ stock: SearchStocksModel) -> ()) {
        
        let urlString = "https://finnhub.io/api/v1/search?q\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default) //создаем дефолтную сессию
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in //создаем задание для сессии
                if error != nil { //проверяем есть ли ошибка, если да - скипаем всю функцию
                    print(error!) // и печатаем ошибку //печатали ошибку
                    return // return значит выйти из функции handle
                }
                if let safeData = data { //анрапим дату в if statement'е чтобы убедиться что там не nil
                    
                    guard let stock = decodeJson(stockName: stockName, safeData) else {return}
                    
                    completion(stock)
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    
    private func decodeJson(stockName: String, _ data: Data) -> SearchStocksModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(SearchStocksModel.self, from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
}
