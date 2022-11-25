//
//  NewsFeedHandler.swift
//  My Stocks
//
//  Created by Dmitry on 24.11.2022.
//

import Foundation

final class NewsFeedHandler {
    
    private let dataFetcherService = DataFetcherService()
    
    func loadNewsArray(tikersArray: [String], completion: @escaping ([NewsModel]?) -> Void ) {
        var newsModelsArray = [NewsModel]()
        let group = DispatchGroup()
        for i in tikersArray {
            group.enter()
            dataFetcherService.fetchNews(stockName: i) { array in
                guard let model = array else {return}
                newsModelsArray += model
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(newsModelsArray)
        }
    }
}
