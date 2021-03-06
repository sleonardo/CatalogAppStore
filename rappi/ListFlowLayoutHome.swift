//
//  ListFlowLayout.swift
//  rappi
//
//  Created by Leonardo Simoza on 24/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit

class ListFlowLayoutHome: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 200
    
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 25
        minimumLineSpacing = 25
        scrollDirection = .vertical
        let device = UIDevice.current.localizedModel
        if device.contains("iPhone") {
            self.itemHeight = 150
        } else {
           self.itemHeight = 200
        }
    }
    
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width
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
