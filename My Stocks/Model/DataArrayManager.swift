//
//  DataArrayManager.swift
//  My Stocks
//
//  Created by Dmitry on 18.10.2022.
//

import Foundation

let dataManager = DataManager()

func getStocksArray(tikersArray: [String], completion: @escaping (Int, StockModel) -> Void ) {
    
    for (index, item) in tikersArray.enumerated() {
        
        dataManager.performRequest(stockName: item) { stock in
            completion(index,stock)
        }
        
//        getCoordinateFrom(city: item) { coordinate, error in
//            guard let coordinate = coordinate, error == nil else {return}
//            //print(coordinate.latitude,coordinate.longitude)
//            networkWeatherManager.fetchWeather(latitude: coordinate.latitude,
//                                               longitude: coordinate.longitude) { weather in
//                completion(index,weather)
//            }
//        }
    }
}
