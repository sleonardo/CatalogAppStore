//
//  BaseController.swift
//  rappi
//
//  Created by Leonardo Simoza on 22/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tap)
    }
    
    func tapOutside(){
        view.endEditing(true)
    }
    
    func setup(){}
}
