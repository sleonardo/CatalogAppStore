//
//  GlobalConstants.swift
//  rappi
//
//  Created by Leonardo Simoza on 23/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import UIKit

struct GlobalConstants {
    
    //MARK: CONSTANTS
    static let errorDomain = "Server Error"
    
    //MARK: ENVIROMENT
    struct Dev { //MARK: DEVELOMENT
        static let baseUrl = "https://itunes.apple.com/us/rss/" //DEV
        static func getTopFreeAppsWithLimit(limit:String)->String{
            return "\(baseUrl)/topfreeapplications/limit=\(limit)/json"
        }
    }
    
    //MARK: SERVICES
    struct nameServices {
        static let getTopFreeApps = "TopFreeApps"
    }
}
