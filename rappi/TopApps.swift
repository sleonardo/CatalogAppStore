//
//  TopApps.swift
//  rappi
//
//  Created by Leonardo Simoza on 23/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Gloss

public struct TopApps: Decodable {
    
    public let feed: Feed
    
    // MARK: - Deserialization
    public init?(json: JSON) {
        guard let feed: Feed = "feed" <~~ json
            else { return nil }
        
        self.feed = feed
    }
    
}
