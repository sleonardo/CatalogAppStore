//
//  App.swift
//  rappi
//
//  Created by Leonardo Simoza on 23/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AppModel {
    
    var imageURLString:String? = nil
    var name:String? = nil
    var link:String? = nil
    var price:Float? = 0.0
    var summary:String? = nil
    var artist:String? = nil
    var categoryModel:CategoryModel = CategoryModel()
//    var releaseDate : String!
//    var linkiTunes : String!
//    var rights : String!
//    var title : String!
    
    init(){}
    
    func unwrapping(entityJson:JSON){
        self.imageURLString = entityJson["im:image"][1]["label"].stringValue
        self.name = entityJson["im:name"]["label"].stringValue
        //Option 1 for access to dictionary within another dictionary
        self.link = entityJson["im:link"]["attributes"]["label"].stringValue
        //Option 2 for access to dictionary within another dictionary
        let priceJson = entityJson["im:price"]
        self.price = priceJson["attributes"]["amount"].floatValue
        //Option 3 for access to dictionary within another dictionary
        let categoryJson = entityJson["category"]["attributes"].dictionary
        self.categoryModel.unwrapping(entityJson: categoryJson!)
        self.summary = entityJson["summary"]["label"].stringValue
        self.artist = entityJson["im:artist"]["label"].stringValue

    }
    func alloc() -> AppModel {return AppModel()}
}


/*
import Gloss

public struct App: Decodable {
    
    public let name: String
    public let link: String
    public let summary: String
    public let price: String
    public let currency: String
    public let category: String
    public let title: String
    
    public init?(json: JSON) {

        guard let nameCont: JSON = "im:name" <~~ json,
            let idCont: JSON = "id" <~~ json,
            let summaryCont: JSON = "summary" <~~ json,
            let priceCont: JSON = "im:price" <~~ json,
            let categoryCont: JSON = "category" <~~ json,
            let titleJson = json["title"] as? JSON, let title: String = "label" <~~ titleJson

            else { return nil }
        
        guard let name: String = "label" <~~ nameCont,
            let link: String = "label" <~~ idCont,
            let summary: String = "label" <~~ summaryCont,
            let dataJSON1 = priceCont["attributes"] as? JSON, let price: String = "amount" <~~ dataJSON1,
            let dataJSON2 = priceCont["attributes"] as? JSON, let currency: String = "currency" <~~ dataJSON2,
            let categoryJson = categoryCont["attributes"] as? JSON, let category: String = "label" <~~ categoryJson
            else { return nil }
        
        self.name = name
        self.link = link
        self.summary = summary
        self.price = price
        self.currency = currency
        self.category = category
        self.title = title
    }
    

    
}
*/
