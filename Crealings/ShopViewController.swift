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
    
    var foodArray: [NSDictionary] = [];
    var drinkArray: [NSDictionary] = [];
    var toysArray: [NSDictionary] = [];
    var selectedCell: Int = Int();
    
    var gameData: GameData?;
    
    override func viewDidLoad() {
        gameData = GameData();
        gameData?.loadData();
        
        hideItemData();
        
        foodArray = gameData!.getFoodItemsArray();
        drinkArray = gameData!.getDrinkItemsArray();
        toysArray = gameData!.getToyItemsArray();
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
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
        selectedCell = indexPath.row;
        var view: String = String();
        var item: NSDictionary? = nil;
        
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
    
    func setAlertData (collectionView: UICollectionView, indexPath: Int) -> Bool {
        var item: NSDictionary? = nil;
        
        switch collectionView {
        case collection1:
            item = foodArray[indexPath];
        case collection2:
            item = drinkArray[indexPath];
        case collection3:
            item = toysArray[indexPath];
        default:
            break;
        }
        
        if (item != nil) {
            itemName.text = item!["name"] as? String;
            itemCost.text = toString(item!["cost"]!);
            itemDescription.text = item!["description"] as? String;
            numOwned.text = toString(item!["numOwned"]!);
            itemImage.image = UIImage(named: (item!["imageName"] as String));
            
            return true;
        }
        
        return false;
    }
    
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
    
    @IBAction func buyButton(sender: UIButton) {
        
    }
    
    @IBAction func closeButton(sender: UIButton) {
        hideItemData();
    }
}
