//
//  DetailViewController.swift
//  rappi
//
//  Created by Leonardo Simoza on 28/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class DetailViewController: BaseController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var imageDetailView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    
    var itemDetail = [AppModel]()
    var currentIndexDetail = 0

    override func setup() {
        let itemToDisplay = itemDetail[currentIndexDetail]
        nameLabel.text = itemToDisplay.name
        summaryLabel.text = itemToDisplay.summary
        categoryLabel.text = itemToDisplay.categoryModel.category
        let price = itemToDisplay.price
        let amount = NSString(format: "$ %.2f", price!)
        let urlString = itemToDisplay.imageURLString
        let url = URL(string: urlString!)
        priceLabel.text = amount as String
        imageDetailView.sd_setImage(with: url)
    }
}
