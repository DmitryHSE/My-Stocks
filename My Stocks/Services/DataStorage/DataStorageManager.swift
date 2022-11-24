//
//  DataStorageManager.swift
//  My Stocks
//
//  Created by Dmitry on 24.10.2022.
//

import Foundation

final class DataStorageManager {
    
    let userDefaults = UserDefaults.standard
    
    func addStockToStorage(ticker: String, key: String) {
        if var array = userDefaults.stringArray(forKey: key) {
            array.append(ticker)
            userDefaults.set(array, forKey: key)
            print(userDefaults.stringArray(forKey: key)!)
        } else {
            var array = [String]()
            array.append(ticker)
            userDefaults.set(array, forKey: key)
            print(userDefaults.stringArray(forKey: key)!)
        }
        
    }
    func removeStockFromStorage(ticker: String, key: String) {
        var array = userDefaults.stringArray(forKey: key)!
        if let index = array.firstIndex(of: ticker) {
            array.remove(at: index)
        }
        userDefaults.set(array, forKey: key)
        print(userDefaults.stringArray(forKey: key)!)
    }
}




