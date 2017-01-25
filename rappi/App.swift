//
//  App.swift
//  rappi
//
//  Created by Leonardo Simoza on 22/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class App {
    
    var imageURLString:String? = nil
    var name:String? = nil
    
    init(appJson:JSON){
        self.imageURLString = appJson["im:image"][0]["label"].string
        self.name = appJson["im:name"]["label"].string
    }
    
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
