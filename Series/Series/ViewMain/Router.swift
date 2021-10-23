//
//  Router.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

extension ViewController{
    func routeToDetail(type: ItemType, item: Item){
        let viewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsView") as! DetailsViewController
        
        viewController.itemId = item.id
        viewController.type = type
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
