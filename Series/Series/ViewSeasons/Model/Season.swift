//
//  Season.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class Season: Codable {
    let air_date: String?
    let episode_count: Int
    let id: Int
    let name: String
    var overview: String?
    let season_number: Int
}
