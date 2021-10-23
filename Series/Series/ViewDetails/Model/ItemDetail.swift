//
//  ItemDetail.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ItemDetail: Object, Codable {
    @Persisted var backdrop_path: String?
    @Persisted var original_title: String?
    @Persisted var name: String?
    @Persisted var overview: String
    @Persisted var poster_path: String?
    @Persisted(primaryKey: true) var id: Int
    @Persisted var vote_average: Float
    @Persisted var first_air_date: String?
    @Persisted var runtime: Int?
    @Persisted var release_date: String?
    @Persisted var number_of_seasons: Int?
    
    /*override init() {
        super.init()
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
    }*/
}
