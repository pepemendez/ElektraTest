//
//  List.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class List: Codable {
    let page: Int
    let results: [Item]
}
