//
//  ViewModelDetail.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class ViewModelDetail{
    
    var refreshData = {}
        
    var data: ItemDetail? = nil {
        didSet {
            refreshData()
        }
    }
    
    var videos: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveData(type: ItemType, itemId: Int){
        switch type {
        case .MoviePlaying, .MoviePopular:
            Connector().getMovieVideos(itemId: itemId, completion: videosRetrived)
            Connector().getMovieDetails(itemId: itemId, completion: dataRetrived)
        case .SeriePopular, .SeriePlaying:
            Connector().getSerieVideos(itemId: itemId, completion: videosRetrived)
            Connector().getSerieDetails(itemId: itemId, completion: dataRetrived)
        default:
            print("ERROR")
        }

    }
    
    func dataRetrived(_ success: Bool, _ response: ItemDetail){
        if(success){
            self.data = response
        }
    }
    
    func videosRetrived(_ success: Bool, _ response: [Video]){
        if(success){
            self.videos = response
        }
    }
    
}
