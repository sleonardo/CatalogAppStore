//
//  PersistenceManager.swift
//  rappi
//
//  Created by Leonardo Simoza on 30/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistenceManager {
    class private func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory as NSString
    }
    
    func getDataByEntity(entityName: String) -> [NSManagedObject]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var entry: [NSManagedObject]!
        do {
            let results = try managedContext.fetch(fetchRequest)
            entry = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return entry
    }
}
