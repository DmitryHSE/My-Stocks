//
//  NewsModel.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import Foundation

struct NewsModel: Codable {
    var category: String = "n/a"
    var datetime: Int = 0
    var headline: String = "n/a"
    var id: Int = 0
    var image: String? // was optional
    var related: String = "n/a"
    var source: String = "n/a"
    var summary: String = "n/a"
    var url: String = ""
}
