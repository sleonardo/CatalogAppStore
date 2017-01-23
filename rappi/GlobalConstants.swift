//
//  GlobalConstants.swift
//  rappi
//
//  Created by Leonardo Simoza on 22/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import UIKit

struct GlobalConstants {
    //ENVIROMENT
    struct Dev { //DEVELOPMENT
        static let baseUrl = "https://itunes.apple.com/us/rss/topfreeapplications/limit=5/json" //DEV
    }
    
    struct nameServices {
        static let getTopFreeApps = "TopFreeApps"
    }
}
