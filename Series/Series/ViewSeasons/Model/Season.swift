//
//  Season.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class Season: Object, Codable {
    @Persisted var air_date: String?
    @Persisted var episode_count: Int
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var overview: String?
    @Persisted var season_number: Int
}
