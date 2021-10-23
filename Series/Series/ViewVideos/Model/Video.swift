//
//  Video.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class Video: Object, Codable {
    @Persisted var name: String
    @Persisted var key: String
    @Persisted var site: String
    @Persisted var type: String
    @Persisted var official: Bool
    @Persisted var published_at: String
    @Persisted(primaryKey: true) var id: String
}
