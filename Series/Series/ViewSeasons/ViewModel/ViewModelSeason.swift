//
//  ViewModelSeason.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class ViewModelSeason{
    
    var refreshData = {}
    
    var data: [Season] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retreiveData(type: ItemType, itemId: Int){
        Connector().getSerieSeasonsDetails(itemId: itemId, completion: dataRetrived)
    }
    
    func dataRetrived(_ success: Bool, _ response: [Season]){
        if(success){
            self.data = response
        }
    }
}
