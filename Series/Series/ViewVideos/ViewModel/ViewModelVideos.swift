//
//  ViewModelVideos.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class ViewModelVideos{
    
    var refreshData = {}
    
    var data: [Video] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveData(type: ItemType, itemId: Int){
        switch type {
        case .MoviePlaying, .MoviePopular:
            Connector().getMovieVideos(itemId: itemId, completion: videosRetrived)
        case .SeriePopular, .SeriePlaying:
            Connector().getSerieVideos(itemId: itemId, completion: videosRetrived)
        default:
            print("ERROR")
        }

    }
    
    func videosRetrived(_ success: Bool, _ response: [Video]){
        if(success){
            self.data = response
        }
    }
    
}
