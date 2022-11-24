//
//  NetworkDataFetcher.swift
//  My Stocks
//
//  Created by Dmitry on 13.11.2022.
//

import Foundation

protocol DataFetcher {
    func dataFetcher<T: Decodable>(urlString: String, response: @escaping(T?) -> Void)
}

final class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    // декодирование полученных данных
    func dataFetcher<T: Decodable>(urlString: String, response: @escaping(T?) -> Void) {
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Failed to fetch data: ",error)
                response(nil)
            }
            let decoded = self.decodeJson(type: T.self, data: data)
            response(decoded)
        }
    }
    
    func decodeJson<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON: ", jsonError)
            return nil
        }
    }
}
