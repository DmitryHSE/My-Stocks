//
//  NewsFeedHandler.swift
//  My Stocks
//
//  Created by Dmitry on 24.11.2022.
//

import Foundation

class NewsFeedHandler {
    
    private let dataFetcherService = DataFetcherService()
    
    func loadNews(tikersArray: [String], completion: @escaping ([NewsModel]) -> Void ) {
        for i in tikersArray {
            dataFetcherService.fetchNews(stockName: i) { array in
                guard let model = array else {return}
                completion(model)
            }
        }
    }
}
