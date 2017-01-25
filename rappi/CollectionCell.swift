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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
