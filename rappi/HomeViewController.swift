//
//  ViewController.swift
//  rappi
//
//  Created by Leonardo Simoza on 21/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import SwiftyJSON
import Alamofire
import BTNavigationDropdownMenu

//import Alamofire_Gloss

class HomeViewController: BaseController {

    @IBOutlet var tblJSON: UITableView!
    @IBOutlet weak var selectedCellLabel: UILabel!
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var jsons: [String: AnyObject]!
    var topAppDic: [String: AnyObject]!

    var menuView: BTNavigationDropdownMenu!

    override func setup() {
        
        ServiceWrapper.requestGETURL(GlobalConstants.Dev.baseUrl, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)

        
            /*do {
//                self.json = try JSONSerialization.jsonObject(with: JSONResponse.rawData(), options: JSONSerialization.ReadingOptions()) as? TopApps
                
//                try self.json = JSONSerialization.jsonObject(with: JSONResponse.rawData(), options: JSONSerialization.ReadingOptions(rawValue: 0)) as? JSON
                
            } catch {
                print(error)
            }*/
            
        }) {
            (error) -> Void in
            print(error)
        }
        
        
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items as [AnyObject])
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self.selectedCellLabel.text = items[indexPath]

        }
        self.navigationItem.titleView = menuView
        /*Alamofire.request(GlobalConstants.Dev.baseUrl)
            .responseObject(TopApps.self) { (response) in
                print (response)
            switch response.result {
            case .success(let topApps):
                //var resData = [Feed]()
                    //topApps["feed"].arrayObject
                print("Top Free Apps: \(topApps)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }*/
        /*
        Alamofire.request(GlobalConstants.Dev.baseUrl)
            .responseObject(TopApps) { (response) in
                print(response)
                
                //to get status code
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        // 1
                        let repoOwners: [TopApps]? = [TopApps].from(data: response)
                        
                        guard let value = response.result.value as? JSON,
                            let eventsArrayJSON = value["events"] as? [JSON] //Thus spake the particular API's docs
                            else { fatalError() }
                        let events = [TopApps].fromJSONArray(eventsArrayJSON)
                        
                        guard let responseJSON = response.result.value as? [String: Any],
                            let results = responseJSON["feed"] as? Feed else {
                                print("Invalid color information received from service")
                                return
                        }
                        print("******************************")
                        print(results)
                        print("******************************")
                        
                        /*
                        guard let responseJSON = response.result.value as? [String: Any],
                            let results = responseJSON["feed"] as? [[String: Any]] else {
                                print("Invalid color information received from service")
                                return
                        }*/
                        break
                    default:
                        print("error with response status: \(status)")
                    }
                }
                //to get JSON return value
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                }
                
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

