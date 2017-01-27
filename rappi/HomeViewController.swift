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
import SDWebImage
//import Alamofire_Gloss
//import Gloss

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    /// CollectionView to display our items in grid and list view
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tblJSON: UITableView!
    @IBOutlet weak var selectedCellLabel: UILabel!

    @IBOutlet var gridButton: UIButton!
    @IBOutlet var listButton: UIButton!
    
    //@IBOutlet var profileTitleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    //@IBOutlet var profileImageView: UIImageView!
    @IBOutlet var headerView: UIView!
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var jsons: [String: AnyObject]!
    var topAppDic: [String: AnyObject]!

    var menuView: BTNavigationDropdownMenu!
    var appCollectionResponse = [App]()
    var dataJson = [JSON]()
    
    /// Items to display
    var itemsToDisplay: [ImageToDisplay] = []
    /// Flow layout that displays cells with a Grid layout
    let gridFlowLayout = GridFlowLayout()
    /// Flow layout that displays cells with a List layout, like in a tableView
    let listFlowLayout = ListFlowLayout()
    
    /// True if the current flow layout is a grid
    var isGridFlowLayoutUsed: Bool = false {
        didSet {
            listButton.alpha = (isGridFlowLayoutUsed == true) ? 0.9 : 1.0
            gridButton.alpha = (isGridFlowLayoutUsed == true) ? 1.0 : 0.9
        }
    }

    override func viewDidLoad() {
        
        ServiceWrapper.requestGETURL(GlobalConstants.Dev.baseUrl, success: {
            (JSONResponse) -> Void in
            print("+--------------+--------------+--------------+--------------+")
            print(JSONResponse)

            self.dataJson = (JSONResponse)["feed"]["entry"].arrayValue

            /*
             let swiftyJsonVar = (JSONResponse)["feed"]
             
             if let resData = swiftyJsonVar["entry"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
             }
             */
        }) {
            (error) -> Void in
            print(error)
        }

        /*Alamofire.request(GlobalConstants.Dev.baseUrl)
            .validate()
            .responseJSON { response in
                // If the result is succes populate the table, otherwise show debug description
                if response.result.isSuccess {
                    self.dataJson = (JSON(response.result.value!))["feed"]["entry"].arrayValue
                } else {
                    print(response.debugDescription)
                }
        }*/

/*
        Alamofire.request(GlobalConstants.Dev.baseUrl)
            .validate()
            .responseJSON { response in
                // If the result is succes populate the table, otherwise show debug description
                if response.result.isSuccess {
                    self.dataJson = JSON(response.result.value!)
                    print(self.dataJson)
                } else {
                    print(response.debugDescription)
                }
        }*/
        /*
        Alamofire.request(GlobalConstants.Dev.baseUrl).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
            }
        }*/
        
        // apple structures the array of apps in feed.entry
//        let feedArray = dataJson["feed"]["entry"]
        // load up the app item objects into an array and pass it to the callback
        
        
//        for (_, feed) in feedArray {
//            appCollectionResponse.append(App(appJson: feed))
//        }
//        print("+--------------+--------------+--------------+--------------+")
        
//        print("+--------------+--------------+--------------+--------------+")
        
        /*
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
        */
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
        
        setupDatasource()
        setupInitialLayout()
    }
    
    func setupDatasource() {
        itemsToDisplay = [ImageToDisplay(imageName: "1"), ImageToDisplay(imageName: "2"), ImageToDisplay(imageName: "3"), ImageToDisplay(imageName: "4"),
                          ImageToDisplay(imageName: "5"), ImageToDisplay(imageName: "6"), ImageToDisplay(imageName: "7"), ImageToDisplay(imageName: "8"),
                          ImageToDisplay(imageName: "9"), ImageToDisplay(imageName: "10")]
        
        collectionView.reloadData()
        
        //        detailLabel.text = "\(itemsToDisplay.count)" + " photos"
    }
    
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func listButtonPressed() {
        // change to list layout
        isGridFlowLayoutUsed = false
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
        })
    }
    
    @IBAction func gridButtonPressed() {
        // change to grid layout
        isGridFlowLayoutUsed = true
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        //let itemToDisplay = itemsToDisplay[indexPath.row]
        let itemToDisplay = dataJson[indexPath.row]
//        cell.imageView.image = UIImage(named: "\(itemToDisplay.imageName)"+".jpg")
        let urlString = itemToDisplay["im:image"][2]["label"].string
        
        let url = URL(string: urlString!)
        cell.imageView.sd_setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataJson.count)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }

}


