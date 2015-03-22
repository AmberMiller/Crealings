//
//  ShopViewController.swift
//  Crealings
//
//  Created by Amber Miller on 3/14/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collection1: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet weak var collection3: UICollectionView!
    
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var numOwned: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var foodArray: [Dictionary <String, AnyObject>] = [];
    var drinkArray: [Dictionary <String, AnyObject>] = [];
    var toysArray: [Dictionary <String, AnyObject>] = [];
    
    var gameData: GameData = GameData.sharedInstance;
    
    var selectedItem: Dictionary <String, AnyObject>? = nil;
    var selectedItemCollection: String = String();
    var selectedIndex: Int = Int();
    
    /***********************************************************
        Load
    ************************************************************/
    
    override func viewDidLoad() {
        
        hideItemData();
        loadData();
    }
    
    func loadData () {
        if (gameData.loadData()) {
            foodArray = gameData.getFoodItemsArray();
            drinkArray = gameData.getDrinkItemsArray();
            toysArray = gameData.getToyItemsArray();
        }
    }
    

    
    /***********************************************************
        Collection View Setup
    ************************************************************/
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: itemCell = itemCell();
        var item: NSDictionary? = nil;

        switch collectionView {
            case collection1:
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as itemCell;
                item = foodArray[indexPath.row];
            
            case collection2:
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath) as itemCell;
                item = drinkArray[indexPath.row];

            case collection3:
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell3", forIndexPath: indexPath) as itemCell;
                item = toysArray[indexPath.row];

            default:
                break;
        }
        
        if (item != nil) {
            let imageName: AnyObject? = item!["imageName"];
            cell.itemImage.image = UIImage(named: imageName as String);
        }
        
        let height: CGFloat = collectionView.frame.height - 10.0;
        cell.frame.size = CGSizeMake(height, height);
        cell.center.y = collectionView.frame.size.height / 2;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collection1:
            return foodArray.count;
        case collection2:
            return drinkArray.count;
        case collection3:
            return toysArray.count;
        default:
            return 0;
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        var view: String = String();
        var item: Dictionary <String, AnyObject>? = nil;
        
        switch collectionView {
            case collection1:
                view = "Collection1";
                item = foodArray[indexPath.row];
            case collection2:
                view = "Collection2";
                item = drinkArray[indexPath.row];
            case collection3:
                view = "Collection3";
                item = toysArray[indexPath.row];
            default:
                break;
        }
        let name: AnyObject? = item!["name"] as String;
        println("Collection: \(view) Selected Item: \(name)");
        if (setAlertData(collectionView, indexPath: indexPath.row)) {
            showItemData();
        }
    }
    
    /***********************************************************
        Info Alert
    ************************************************************/
    
    /* Get data from selected item and display in info alert */
    func setAlertData (collectionView: UICollectionView, indexPath: Int) -> Bool {
        
        switch collectionView {
        case collection1:
            selectedItem = foodArray[indexPath];
            selectedItemCollection = "food";
        case collection2:
            selectedItem = drinkArray[indexPath];
            selectedItemCollection = "drink";
        case collection3:
            selectedItem = toysArray[indexPath];
            selectedItemCollection = "toys";
        default:
            break;
        }
        
        if (selectedItem != nil) {
            itemName.text = selectedItem!["name"] as? String;
            itemCost.text = toString(selectedItem!["cost"]!);
            itemDescription.text = selectedItem!["description"] as? String;
            numOwned.text = toString(selectedItem!["numOwned"]!);
            itemImage.image = UIImage(named: (selectedItem!["imageName"] as String));
            
            return true;
        }
        
        return false;
    }
    
    /* Show Info Alert */
    func showItemData () {
        alertImage.hidden = false;
        itemName.hidden = false;
        itemCost.hidden = false;
        itemDescription.hidden = false;
        numOwned.hidden = false;
        itemImage.hidden = false;
        costLabel.hidden = false;
        ownedLabel.hidden = false;
        buyButton.hidden = false;
        exitButton.hidden = false;
    }
    
    /* Hide Info Alert */
    func hideItemData () {
        alertImage.hidden = true;
        itemName.hidden = true;
        itemCost.hidden = true;
        itemDescription.hidden = true;
        numOwned.hidden = true;
        itemImage.hidden = true;
        costLabel.hidden = true;
        ownedLabel.hidden = true;
        buyButton.hidden = true;
        exitButton.hidden = true;
    }
    
    
    /***********************************************************
        Button Actions
    ************************************************************/
    
    /* Set item data when leaving controller */
    @IBAction func backButton(sender: UIButton) {
        gameData.writeItems(foodArray, key: "Food");
        gameData.writeItems(drinkArray, key: "Drinks");
        gameData.writeItems(toysArray, key: "Toys");
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /* Increase numOwned for item and set in array */
    @IBAction func buyButton(sender: UIButton) {
        //TODO Check user coins and compare to item cost
        if (selectedItem != nil) {
            var itemNumOwned: Int = selectedItem!["numOwned"] as Int;
            itemNumOwned += 1;
            selectedItem!.updateValue(itemNumOwned, forKey: "numOwned");
            
            numOwned.text = toString(itemNumOwned);
            
            //TODO Subtract coins for cost
            
            switch selectedItemCollection {
                case "food":
                    foodArray[selectedIndex] = selectedItem!;
                    println("Food Array: \(foodArray)");
                case "drink":
                    drinkArray[selectedIndex] = selectedItem!;
                case "toys":
                    toysArray[selectedIndex] = selectedItem!;
                default:
                    println("No Collection");
            }
        }
    }
    
    /* Close Info Alert */
    @IBAction func closeButton(sender: UIButton) {
        selectedItem = nil;
        hideItemData();
    }
}
