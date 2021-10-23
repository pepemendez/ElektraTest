//
//  ViewModelList.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ViewModelList{
    
    var refreshData = {}
    
    var moviePopular: [Item] = [] {
        didSet {
            refreshData()
        }
    }
    
    var moviePlayingNow: [Item] = [] {
        didSet {
            refreshData()
        }
    }
    
    var seriePopular: [Item] = [] {
        didSet {
            refreshData()
        }
    }
    
    var seriePlayingNow: [Item] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveLocalData(type: ItemType) -> [Item]{
        let realm = try! Realm()
        var ids = [Int]()
        let persisted = realm.objects(PeristedList.self).filter("type == \(type.rawValue)")
        persisted.forEach { item in
            print(item.id)
            ids.append(item.id)
        }
        
        let items = realm.objects(Item.self).filter("id IN %@", ids)
        
        return Array(items)
    }
    
    func storeLocalData(type: ItemType, data: [Item]){
        let realm = try! Realm()
        
        let previousObjects = realm.objects(PeristedList.self)
        
        try! realm.write{
            realm.delete(previousObjects)
        }
        
        data.forEach({
            item in
            let persisted = PeristedList()
            persisted.type = type.rawValue
            persisted.id = item.id
            try! realm.write {
                realm.add(persisted, update: .all)
                realm.add(item, update: .all)
            }
        })
    }
    
    func retreiveDataList(type: ItemType){
        switch type {
        case .MoviePlaying:
            getMovieNowPlayingResponse(true, retreiveLocalData(type: type))
            Connector().getMovieNowPlaying(completion: getMovieNowPlayingResponse)
            break
        case .MoviePopular:
            getMoviePopularResponse(true, retreiveLocalData(type: type))
            Connector().getMoviePopular(completion: getMoviePopularResponse)
            break
        case .SeriePlaying:
            getSerieNowPlayingResponse(true, retreiveLocalData(type: type))
            Connector().getSerieNowPlaying(completion: getSerieNowPlayingResponse)
            break
        case .SeriePopular:
            getSeriePopularResponse(true, retreiveLocalData(type: type))
            Connector().getSeriePopular(completion: getSeriePopularResponse)
            break
        default:
            print("Error")
        }
    }
    
    func getMovieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.moviePlayingNow = response
                
                self.storeLocalData(type: .MoviePlaying, data: self.moviePlayingNow)
            }
        }
    }
    
    func getMoviePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.moviePopular = response

                self.storeLocalData(type: .MoviePopular, data: self.moviePopular)
            }
        }
    }
    
    func getSerieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.seriePlayingNow = response

                self.storeLocalData(type: .SeriePlaying, data: self.seriePlayingNow)
            }
        }
    }
    
    func getSeriePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.seriePopular = response

                self.storeLocalData(type: .SeriePopular, data: self.seriePopular)
            }
        }
    }
    
}
