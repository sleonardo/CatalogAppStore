//
//  CategoryViewController.swift
//  rappi
//
//  Created by Leonardo Simoza on 29/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class CategoryViewController: BaseController, UICollectionViewDataSource, UICollectionViewDelegate,  UIViewControllerTransitioningDelegate {
    
    //MARK: Outlet
    // CollectionView to display our items in grid and list view
    @IBOutlet var collectionView: UICollectionView!
    var categoryId: String! = nil
    
    //MARK: Parameters
    var categoryModelArray = [CategoryModel]()
    var dataJson = [JSON]()
    var currentIndex = 0
    var categoryModel:CategoryModel!
    var appCollectionResponse = [AppModel]()
    
    // Flow layout that displays cells with a Grid layout
    let gridFlowLayout = GridFlowLayout()
    // Flow layout that displays cells with a List layout, like in a tableView
    let listFlowLayout = ListFlowLayout()
    
    // True if the current flow layout is a grid
    var isGridFlowLayoutUsed: Bool = false /*{
        didSet {
            listButton.alpha = (isGridFlowLayoutUsed == true) ? 0.9 : 1.0
            gridButton.alpha = (isGridFlowLayoutUsed == true) ? 1.0 : 0.9
        }
    }*/

    //MARK: Init
    override func setup() {
        callCategoryRequest()
        setupInitialLayout()
    }
    
    //MARK: API Calls
    func callCategoryRequest(){
        
        //Access to CoreData
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entityApps = NSEntityDescription.insertNewObject(forEntityName: "apps", into: context)
//        let entityCategories = NSEntityDescription.insertNewObject(forEntityName: "categories", into: context)
        
        ServiceWrapper.requestGETURL(GlobalConstants.Dev.getTopFreeAppsWithLimit(limit: "10"), success: {
            (JSONResponse) -> Void in
            print("+--------------+--------------+--------------+--------------+")
            print(JSONResponse)
            self.dataJson = (JSONResponse)["feed"]["entry"].arrayValue
            for data in self.dataJson {
                let newApp: AppModel = AppModel()
                newApp.unwrapping(entityJson: data)
                var cat : CategoryModel = CategoryModel()
                cat = newApp.categoryModel
                let isContained = self.categoryModelArray.contains(where: { element in
                    return ((element.categoryId) == cat.categoryId! as Int)
                })
                if !isContained {
                    self.categoryModelArray.append(cat)
                }
                self.appCollectionResponse.append(newApp)
            }
            self.collectionView.reloadData()
        }) {
            (error) -> Void in
            print(error)
        }
    }
    
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
        
        let itemToDisplay = categoryModelArray[indexPath.row]
        cell.button.setTitle(itemToDisplay.category, for: .normal)
        cell.button.restorationIdentifier = String(_:itemToDisplay.categoryId!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (categoryModelArray.count)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: Segue - Sends information of the selected app to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueApp" {
            let homeVC = segue.destination as! HomeViewController
            homeVC.currentIndex = self.currentIndex
            var appsByCategory = [AppModel]()
            for data in appCollectionResponse{
                let appNew: AppModel = data
                if Int(_:self.categoryId) == appNew.categoryModel.categoryId {
                    appsByCategory.append(appNew)
                }
            }
            homeVC.appCollectionResponse = appsByCategory
            homeVC.transitioningDelegate = self

        }
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.categoryId = sender.restorationIdentifier
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            self.performSegue(withIdentifier: "segueApp", sender: self)
        })
    }
    
}
