//
//  ViewModelSeason.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ViewModelSeason{
    
    var refreshData = {}
    
    var data: [Season] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveLocalData(itemId: Int) -> [Season]{
        let realm = try! Realm()
        var ids = [Int]()
        let persisted = realm.objects(PeristedSeasonList.self).filter("itemId == \(itemId)")
        persisted.forEach { item in
            print(item.id)
            ids.append(item.id)
        }
        
        let items = realm.objects(Season.self).filter("id IN %@", ids)
        
        return Array(items)
    }
    
    func storeLocalData(itemId: Int, data: [Season]){
        let realm = try! Realm()
        
        let previousObjects = realm.objects(PeristedSeasonList.self).filter("itemId == \(itemId)")
        
        try! realm.write{
            realm.delete(previousObjects)
        }
        
        data.forEach({
            item in
            let persisted = PeristedSeasonList()
            persisted.itemId = itemId
            persisted.id = item.id
            try! realm.write {
                realm.add(persisted, update: .all)
                realm.add(item, update: .all)
            }
        })
    }
    
    func retreiveData(type: ItemType, itemId: Int){
        dataRetrived(true, retreiveLocalData(itemId: itemId), itemId)
        Connector().getSerieSeasonsDetails(itemId: itemId, completion: dataRetrived)
    }
    
    func dataRetrived(_ success: Bool, _ response: [Season], _ itemId: Int){
        if(success){
            DispatchQueue.main.async {
                self.data = response

                self.storeLocalData(itemId: itemId, data: self.data)
            }
        }
    }
}
