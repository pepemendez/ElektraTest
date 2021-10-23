//
//  ViewModelDetail.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ViewModelDetail{
    
    var refreshData = {}
        
    var data: ItemDetail = ItemDetail() {
        didSet {
            refreshData()
        }
    }
    
    var videos: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func storeLocalData(data: ItemDetail){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(data, update: .all
            )
        }
    }
    
    func retreiveLocalData(itemId: Int) -> ItemDetail?{
        let realm = try! Realm()
        let item = realm.objects(ItemDetail.self).filter("id == \(itemId)").first
        return item
    }
    
    
    func retreiveData(type: ItemType, itemId: Int){
        switch type {
        case .MoviePlaying, .MoviePopular:
            if let item = retreiveLocalData(itemId: itemId){
                dataRetrived(true, item)
            }
            Connector().getMovieVideos(itemId: itemId, completion: videosRetrived)
            Connector().getMovieDetails(itemId: itemId, completion: dataRetrived)
        break
        case .SeriePopular, .SeriePlaying:
            if let item = retreiveLocalData(itemId: itemId){
                dataRetrived(true, item)
            }
            Connector().getSerieVideos(itemId: itemId, completion: videosRetrived)
            Connector().getSerieDetails(itemId: itemId, completion: dataRetrived)
        break
        default:
            print("ERROR")
        }

    }
    
    func dataRetrived(_ success: Bool, _ response: ItemDetail){
        if(success){
            DispatchQueue.main.async {
                self.data = response
                
                self.storeLocalData(data: self.data)
            }
        }
    }
    
    func videosRetrived(_ success: Bool, _ response: [Video]){
        if(success){
            self.videos = response
        }
    }
    
}
