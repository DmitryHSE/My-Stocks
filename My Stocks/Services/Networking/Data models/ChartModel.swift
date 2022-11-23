//
//  ChartModel.swift
//  My Stocks
//
//  Created by Dmitry on 23.11.2022.
//

import Foundation

struct ChartModel: Codable {
    let c, h, l, o: [Double]
    let s: String // Status of the response. This field can either be ok or no_data. ok
    let t, v: [Int]
}
