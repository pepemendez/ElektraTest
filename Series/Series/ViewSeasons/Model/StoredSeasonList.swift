//
//  StoredSeasonList.swift
//  Series
//
//  Created by Jose Mendez on 23/10/21.
//

import Foundation
import RealmSwift

class PeristedSeasonList: Object {
    @Persisted var itemId: Int
    @Persisted(primaryKey: true) var id: Int
}
