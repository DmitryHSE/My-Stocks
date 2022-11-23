//
//  NewsModel.swift
//  My Stocks
//
//  Created by Dmitry on 20.11.2022.
//

import Foundation

struct NewsModel: Codable {
    let category: String
    let datetime: Int
    let headline: String
    let id: Int
    let image: String?
    let related, source, summary: String
    let url: String
}
