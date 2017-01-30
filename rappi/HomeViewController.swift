//
//  ViewController.swift
//  rappi
//
//  Created by Leonardo Simoza on 23/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import SwiftyJSON
import Alamofire
import BTNavigationDropdownMenu
import SDWebImage
//import Alamofire_Gloss
//import Gloss

class HomeViewController: BaseController, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: Outlet
    // CollectionView to display our items in grid and list view
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: Parameters
    var appCollectionResponse = [AppModel]()
    var dataJson = [JSON]()
    var currentIndex = 0
    var appModel:AppModel!

    // Flow layout that displays cells with a Grid layout
    let gridFlowLayout = GridFlowLayoutHome()
    // Flow layout that displays cells with a List layout, like in a tableView
    let listFlowLayout = ListFlowLayoutHome()
    
    // True if the current flow layout is a grid
    var isGridFlowLayoutUsed: Bool = false
    //MARK: Init
    override func setup() {
        //callAppRequest()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = appCollectionResponse[0].categoryModel.category
        setupInitialLayout()
        self.collectionView.reloadData()
    }

    //MARK: API Calls
    func callAppRequest(){
        ServiceWrapper.requestGETURL(GlobalConstants.Dev.getTopFreeAppsWithLimit(limit: "10"), success: {
            (JSONResponse) -> Void in
            print("+--------------+--------------+--------------+--------------+")
            print(JSONResponse)
            self.dataJson = (JSONResponse)["feed"]["entry"].arrayValue
            for data in self.dataJson {
                let newApp: AppModel = AppModel()
                newApp.unwrapping(entityJson: data)
                self.appCollectionResponse.append(newApp)
            }
            self.collectionView.reloadData()
        }) {
            (error) -> Void in
            print(error)
        }
        
    }
    /*
    func setupDatasource() {
        itemsToDisplay = [ImageToDisplay(imageName: "1"), ImageToDisplay(imageName: "2"), ImageToDisplay(imageName: "3"), ImageToDisplay(imageName: "4"),
                          ImageToDisplay(imageName: "5"), ImageToDisplay(imageName: "6"), ImageToDisplay(imageName: "7"), ImageToDisplay(imageName: "8"),
                          ImageToDisplay(imageName: "9"), ImageToDisplay(imageName: "10")]
        
        collectionView.reloadData()
        
        //        detailLabel.text = "\(itemsToDisplay.count)" + " photos"
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Layout
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
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
    //MARK: Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        let itemToDisplay = appCollectionResponse[indexPath.row]
        let price = itemToDisplay.price
        let amount = NSString(format: "$ %.2f", price!)
        let urlString = itemToDisplay.imageURLString
        let url = URL(string: urlString!)
        cell.priceLabel.text = amount as String
        cell.imageView.sd_setImage(with: url)
        cell.categoryLabel.text = itemToDisplay.categoryModel.category
        cell.nameLabel.text = itemToDisplay.name
        //cell.imageView.downloadImageFrom(link: urlString!, contentMode: .scaleAspectFit)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.item
        self.performSegue(withIdentifier: "seeDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (appCollectionResponse.count)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: Segue - Sends information of the selected app to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.currentIndexDetail = self.currentIndex
            detailVC.itemDetail = self.appCollectionResponse
            self.appModel = self.appCollectionResponse[currentIndex]
        }
    }

}


