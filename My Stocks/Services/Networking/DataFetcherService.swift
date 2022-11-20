//
//  DataFetcherService.swift
//  My Stocks
//
//  Created by Dmitry on 13.11.2022.
//

import Foundation


class DataFetcherService {
    var networkDataFetcher: DataFetcher
   
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = dataFetcher
        
    }
    
    func fetchNews(stockName: String, completion: @escaping([NewsModel]?) -> Void) {
        let url = "https://finnhub.io/api/v1/company-news?symbol=\(stockName)&from=2022-11-18&to=2022-11-20&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        networkDataFetcher.dataFetcher(urlString: url, response: completion)
    }
    
    func fetchStockQuotesData(stockName: String, completion: @escaping(DataModel?) -> Void) {
        let url = "https://finnhub.io/api/v1/quote?symbol=\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        networkDataFetcher.dataFetcher(urlString: url, response: completion)
    }
    
    func fetchStockDetailsData(stockName: String, completion: @escaping(StockDetailsModel?) -> Void) {
        let url = "https://finnhub.io/api/v1/stock/profile2?symbol=\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        networkDataFetcher.dataFetcher(urlString: url, response: completion)
    }
    
    func fetchStockDataForSearchRequest(stockName: String, completion: @escaping(SearchStocksModel?) -> Void) {
        let url = "https://finnhub.io/api/v1/search?q=\(stockName)&token=cclgp8qad3i79c6t85u0cclgp8qad3i79c6t85ug"
        networkDataFetcher.dataFetcher(urlString: url, response: completion)
    }
    
}
