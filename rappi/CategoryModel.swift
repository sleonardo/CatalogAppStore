//
//  CategoryModel.swift
//  rappi
//
//  Created by Leonardo Simoza on 29/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class CategoryModel {
    var category:String? = nil
    var categoryId:Int? = nil
    var categoryUrl:String? = nil
    
    init() {}
    func alloc() -> CategoryModel {return CategoryModel()}

    func unwrapping(entityJson:[String:JSON]){
        //Option 3 for access to dictionary within another dictionary
        self.category = entityJson["label"]?.rawValue as! String?
        self.categoryUrl = entityJson["scheme"]?.rawValue as! String?
        self.categoryId = entityJson["im:id"]?.intValue
    }
    
    
    
}
