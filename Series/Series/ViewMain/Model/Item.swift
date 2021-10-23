//
//  Item.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class Item: Object, Codable {
    @Persisted var original_title: String?
    @Persisted var name: String?
    @Persisted var overview: String?
    @Persisted var poster_path: String?
    @Persisted(primaryKey: true) var id: Int
}
