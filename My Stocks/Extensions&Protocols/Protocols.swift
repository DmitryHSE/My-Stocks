//
//  Protocols.swift
//  My Stocks
//
//  Created by Dmitry on 19.10.2022.
//

import Foundation

protocol PassSearchResultsProtocol {
    func getSearchResults(arrayWithSearchResults: [String])
}

protocol AddTickerToStockListProtocol {
    func getTickerFromSearchScreen(ticker: String)
}

protocol ShowAlertProtocol {
    func showAlert(message: String)
}

protocol ReturnSearchResultsArrayProtocol {
    func getSearchStocksArrayBack(array: [StockForSearchCell])
}


