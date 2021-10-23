//
//  ViewModelList.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

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
    
    func retreiveDataList(type: ItemType){
        switch type {
        case .MoviePlaying:
            Connector().getMovieNowPlaying(completion: getMovieNowPlayingResponse)
            break
        case .MoviePopular:
            Connector().getMoviePopular(completion: getMoviePopularResponse)
            break
        case .SeriePlaying:
            Connector().getSerieNowPlaying(completion: getSerieNowPlayingResponse)
            break
        case .SeriePopular:
            Connector().getSeriePopular(completion: getSeriePopularResponse)
            break
        default:
            print("Error")
        }
    }
    
    func getMovieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            self.moviePlayingNow = response
        }
    }
    
    func getMoviePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            self.moviePopular = response
        }
    }
    
    func getSerieNowPlayingResponse(_ success: Bool, _ response: [Item]){
        if(success){
            self.seriePlayingNow = response
        }
    }
    
    func getSeriePopularResponse(_ success: Bool, _ response: [Item]){
        if(success){
            self.seriePopular = response
        }
    }
    
}
