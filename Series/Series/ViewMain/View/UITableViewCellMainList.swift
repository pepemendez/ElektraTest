//
//  UITableViewCellMainList.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

protocol UITableViewCellMainListDelegate: class {
    func tapped(type: ItemType, at: IndexPath)
    func fetchMore(type: ItemType)
}

class UITableViewCellMainList: UITableViewCell{
    var type: ItemType!
    var data: [Item]!
    weak var delegate : UITableViewCellMainListDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

}

extension UITableViewCellMainList: UICollectionViewCellMainDelegate {
    func tapped(at: IndexPath) {
        self.delegate?.tapped(type: type, at: at)
    }
}

extension UITableViewCellMainList: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentXoffset = scrollView.contentOffset.x
        let width = scrollView.frame.size.width
        let distanceFromBottom = scrollView.contentSize.width - contentXoffset

        //print(contentXoffset, width, distanceFromBottom)
        if distanceFromBottom == width {
            self.delegate?.fetchMore(type: type)
        }
    }
}

extension UITableViewCellMainList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcellprincipal", for: indexPath) as! UICollectionViewCellMain
            
            let object = data[indexPath.row]
            
            if let poster = object.poster_path{
                cell.image.imageFromUrlAndSize(urlString: Endpoints.imagesSmall + poster)
            }
            else{
                cell.image.image = UIImage(#imageLiteral(resourceName: "splash_bg"))

            }
            cell.configure(indexPath: indexPath)
            cell.delegate = self
                        
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcellsecondary", for: indexPath) as! UICollectionViewCellMain
            
            let object = data[indexPath.row]
            
            if let poster = object.poster_path{
                cell.image.imageFromUrlAndSize(urlString: Endpoints.imagesSmall + poster)
            }
            else{
                cell.image.image = UIImage(#imageLiteral(resourceName: "splash_bg"))
            }
            cell.configure(indexPath: indexPath)
            cell.delegate = self

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
}
