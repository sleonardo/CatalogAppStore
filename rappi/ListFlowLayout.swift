//
//  ListFlowLayout.swift
//  rappi
//
//  Created by Leonardo Simoza on 24/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 200
    var viewController: String! = "CategoryViewController"
    
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
        minimumInteritemSpacing = 3
        minimumLineSpacing = 3
        scrollDirection = .vertical
        let device = UIDevice.current.localizedModel
        if viewController.contains("HomeViewController") {
            if device.contains("iPhone") {
                self.itemHeight = 150
            } else {
                self.itemHeight = 200
            }
        }else{
            if device.contains("iPhone") {
                self.itemHeight = 150
            } else {
                self.itemHeight = 200
            }
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
