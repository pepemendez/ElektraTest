//
//  ItemDetail.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class ItemDetail: Codable {
    var backdrop_path: String?
    var original_title: String?
    var name: String?
    let overview: String
    let poster_path: String
    let id: Int
    let vote_average: Float
    var first_air_date: String?
    var runtime: Int?
    var release_date: String?
    var number_of_seasons: Int?
    
    init() {
        number_of_seasons = 0
        runtime = 0
        first_air_date = ""
        vote_average = 0
        backdrop_path = ""
        original_title = ""
        name = ""
        overview = ""
        poster_path = ""
        id = 0
    }
}
