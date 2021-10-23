//
//  ViewModelVideos.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ViewModelVideos{
    
    var refreshData = {}
    
    var data: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveLocalData(itemId: Int) -> [Video]{
        let realm = try! Realm()
        var ids = [String]()
        let persisted = realm.objects(PeristedVideoList.self).filter("itemId == \(itemId)")
        persisted.forEach { item in
            print(item.id)
            ids.append(item.id)
        }
        
        let items = realm.objects(Video.self).filter("id IN %@", ids)
        
        return Array(items)
    }
    
    func storeLocalData(itemId: Int, data: [Video]){
        let realm = try! Realm()
        data.forEach({
            item in
            let persisted = PeristedVideoList()
            persisted.itemId = itemId
            persisted.id = item.id
            try! realm.write {
                realm.add(persisted, update: .all)
                realm.add(item, update: .all)
            }
        })
    }
    
    func retreiveData(type: ItemType, itemId: Int){
        switch type {
        case .MoviePlaying, .MoviePopular:
            videosRetrived(true, retreiveLocalData(itemId: itemId), itemId)
            Connector().getMovieVideos(itemId: itemId, completion: videosRetrived)
        case .SeriePopular, .SeriePlaying:
            videosRetrived(true, retreiveLocalData(itemId: itemId), itemId)
            Connector().getSerieVideos(itemId: itemId, completion: videosRetrived)
        default:
            print("ERROR")
        }

    }
    
    func videosRetrived(_ success: Bool, _ response: [Video], _ itemId: Int){
        if(success){
            DispatchQueue.main.async {
                self.data = response

                self.storeLocalData(itemId: itemId, data: self.data)
            }
        }
    }
    
}
