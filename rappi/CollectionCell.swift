//
//  CollectionCell.swift
//  rappi
//
//  Created by Leonardo Simoza on 24/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var button: UIButton!
    var viewController: String! = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        let device = UIDevice.current.localizedModel
        if self.viewController.contains("HomeViewController"){
            if device.contains("iPad"){
                imageView.image = nil
                priceLabel.text = nil
                categoryLabel.layer.shadowRadius = 2
                categoryLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
                categoryLabel.layer.shadowOpacity = 0.2
            }
        }
    }
}
