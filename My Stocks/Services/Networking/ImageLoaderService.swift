//
//  ImageLoaderService.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit
import SVGKit

struct ImageLoaderService {
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (UIImage?) -> Void) {
        if let imageFromCache = getCacheImage(url: url) {
            onLoadWasCompleted(imageFromCache)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
            }
            // if let data = data, let response = response, let image = UIImage(data: data) {
            let svg = SVGKImage(data: data)
            if let data = data, let response = response, let safeImage = svg?.uiImage {
                saveDataToCach(with: data, response: response)
                onLoadWasCompleted(safeImage)
            } 
        }
        
        dataTask.resume()
    }
}

// MARK: - Cache

private extension ImageLoaderService {
    
    func getCacheImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        guard let chacheedResponse = URLCache.shared.cachedResponse(for: urlRequest) else { return nil }
        //return UIImage(data: chacheedResponse.data)
        let svg = SVGKImage(data: chacheedResponse.data)
        if let image = svg?.uiImage {
            return image
        } else {
            return UIImage(named: "arrowtriangle.down.square")
        }
        
    }
    
    func saveDataToCach(with data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let chacheedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(chacheedResponse, for: urlRequest)
    }
}

// MARK: - UIImageView

//extension UIImageView {
//
//    func loadImage(from url: URL) {
//        image = nil
//
//        ImageLoaderService().loadImage(from: url) { [weak self] result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async { self?.image = image }
//            case .failure(let error):
//                print(error)
//                DispatchQueue.main.async { self?.image = nil }
//            }
//        }
//    }
//
//    func loadImage(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            image = nil
//            return
//        }
//
//        loadImage(from: url)
//    }
//}
