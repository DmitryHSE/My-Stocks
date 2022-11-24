//
//  ImageLoaderService.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import UIKit
import SVGKit

final class ImageLoaderService {
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (UIImage?) -> Void) {
        if let imageFromCache = getCacheImage(url: url) {
            onLoadWasCompleted(imageFromCache)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Failed to load image: ", error)
            }
            let svg = SVGKImage(data: data)
            if let data = data, let response = response, let safeImage = svg?.uiImage {
                self.saveDataToCach(with: data, response: response)
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
        let svg = SVGKImage(data: chacheedResponse.data)
        if let image = svg?.uiImage {
            return image
        } else {
            return UIImage(named: "arrowtriangle.down.square")
        }
        
    }
    
    private func saveDataToCach(with data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let chacheedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(chacheedResponse, for: urlRequest)
    }
}


