//
//  UICollectionViewCell.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

protocol UICollectionViewCellMainDelegate: class {
    func tapped(at: IndexPath)
}

class UICollectionViewCellMain: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    weak var delegate : UICollectionViewCellMainDelegate?
    var indexPath: IndexPath!
    
    func configure(indexPath: IndexPath){
        
        self.indexPath = indexPath
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("imageTapped")
        self.delegate?.tapped(at: indexPath)
    }
    
    

}
