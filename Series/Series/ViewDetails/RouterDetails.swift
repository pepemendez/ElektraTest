//
//  Router.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

extension DetailsViewController{
    func routeToBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func routeToVideos(type: ItemType, id: Int){
        let viewController = UIStoryboard(name: "Videos", bundle: nil).instantiateViewController(withIdentifier: "VideosView") as! VideosViewController
        
        viewController.itemId = id
        viewController.type = type
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func routeToSeasons(type: ItemType, id: Int){
        let viewController = UIStoryboard(name: "Seasons", bundle: nil).instantiateViewController(withIdentifier: "SeasonsView") as! SeasonViewController
        
        viewController.itemId = id
        viewController.type = type
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
