//
//  Feed.swift
//  rappi
//
//  Created by Leonardo Simoza on 22/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Gloss

public struct Feed: Decodable {
    
    public let entries: [App]?
    public let title: String
    public let updated: String
    
    // MARK: - Deserialization
    public init?(json: JSON) {
        guard let entries: [App] = "entry" <~~ json,
            let titleJson = json["title"] as? JSON, let title: String = "label" <~~ titleJson,
            let updatedJson = json["updated"] as? JSON, let updated: String = "label" <~~ updatedJson
            else { return nil }
        
        self.entries = entries
        self.title = title
        self.updated = updated
    }
    
}
