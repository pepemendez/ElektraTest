//
//  StoredList.swift
//  Series
//
//  Created by Jose Mendez on 23/10/21.
//

import Foundation
import RealmSwift

class PeristedList: Object {
    @Persisted var type: Int
    @Persisted(primaryKey: true) var id: Int
}
