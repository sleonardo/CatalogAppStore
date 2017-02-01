//
//  GridFlowLayout.swift
//  rappi
//
//  Created by Leonardo Simoza on 24/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 200
    var minimumItemsByCell: CGFloat = 1
    var viewController: String! = "CategoryViewController"
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 3
        scrollDirection = .vertical
        let device = UIDevice.current.localizedModel
        if viewController.contains("HomeViewController") {
            if device.contains("iPhone") {
                self.itemHeight = 150
                self.minimumItemsByCell = CGFloat(1)
            } else {
                self.minimumItemsByCell = CGFloat(3)
                self.itemHeight = 200
            }
        }else{
            if device.contains("iPhone") {
                self.itemHeight = 70
                self.minimumItemsByCell = CGFloat(1)
            } else {
                self.minimumItemsByCell = CGFloat(3)
                self.itemHeight = 70
            }
        }
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/minimumItemsByCell)-1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}

