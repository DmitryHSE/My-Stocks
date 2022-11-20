//
//  NetworkService.swift
//  My Stocks
//
//  Created by Dmitry on 13.11.2022.
//

import Foundation
import SVGKit

protocol Networking {
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    // постороение запроса
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let task = createDataTask(request: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data,error)
            }
        }
    }
    
}
