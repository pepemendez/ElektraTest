//
//  ViewModelList.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation
import RealmSwift

class ViewModelList{
    
    var refreshData = {(_ type: ItemType) -> () in}
    
    var moviePopularIndex = 1
    var moviePlayingNowIndex = 1
    var seriePopularIndex = 1
    var seriePlayingNowIndex = 1
    
    var moviePopular: [Item] = [] {
        didSet {
            refreshData(.MoviePopular)
        }
    }
    
    var moviePlayingNow: [Item] = [] {
        didSet {
            refreshData(.MoviePlaying)
        }
    }
    
    var seriePopular: [Item] = [] {
        didSet {
            refreshData(.SeriePopular)
        }
    }
    
    var seriePlayingNow: [Item] = [] {
        didSet {
            refreshData(.SeriePlaying)
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
    
    func retreiveMoreDataList(type: ItemType){
        switch type {
        case .MoviePlaying:
            self.moviePlayingNowIndex = self.moviePlayingNowIndex+1
            Connector().getMovieNowPlaying(index: self.moviePlayingNowIndex, completion: appendMovieNowPlayingResponse)
            break
        case .MoviePopular:
            self.moviePopularIndex = self.moviePopularIndex+1
            Connector().getMoviePopular(index: self.moviePopularIndex, completion: appendMoviePopularResponse)
            break
        case .SeriePlaying:
            self.seriePlayingNowIndex = self.seriePlayingNowIndex+1
            Connector().getSerieNowPlaying(index: self.seriePlayingNowIndex, completion: appendSerieNowPlayingResponse)
            break
        case .SeriePopular:
            self.seriePopularIndex = self.seriePopularIndex+1
            Connector().getSeriePopular(index: self.seriePopularIndex, completion: appendSeriePopularResponse)
            break
        }
    }
    
    
    func retreiveDataList(type: ItemType){
        self.moviePopularIndex = 1
        self.moviePlayingNowIndex = 1
        self.seriePopularIndex = 1
        self.seriePlayingNowIndex = 1
        
        switch type {
        case .MoviePlaying:
            getMovieNowPlayingResponse(true, retreiveLocalData(type: type))
            Connector().getMovieNowPlaying(index: 1, completion: getMovieNowPlayingResponse)
            break
        case .MoviePopular:
            getMoviePopularResponse(true, retreiveLocalData(type: type))
            Connector().getMoviePopular(index: 1, completion: getMoviePopularResponse)
            break
        case .SeriePlaying:
            getSerieNowPlayingResponse(true, retreiveLocalData(type: type))
            Connector().getSerieNowPlaying(index: 1, completion: getSerieNowPlayingResponse)
            break
        case .SeriePopular:
            getSeriePopularResponse(true, retreiveLocalData(type: type))
            Connector().getSeriePopular(index: 1, completion: getSeriePopularResponse)
            break
        }
    }
    
    func appendMovieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.moviePlayingNow.append(contentsOf: response)
            }
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
    
    func appendMoviePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.moviePopular.append(contentsOf: response)
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
    
    func appendSerieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.seriePlayingNow.append(contentsOf: response)
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
    
    func appendSeriePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            DispatchQueue.main.async {
                self.seriePopular.append(contentsOf: response)
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
