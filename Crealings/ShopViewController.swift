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
    
    var foodArray: [NSDictionary] = [];
    var drinkArray: [NSDictionary] = [];
    var toysArray: [NSDictionary] = [];
    var selectedCell: Int = Int();
    
    var gameData: GameData?;
    
    override func viewDidLoad() {
        gameData = GameData();
        gameData?.loadData();
        
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
    }
    
    func setupData () {
//        foodArray.removeAll();
//        foodArray.append(itemObject(_itemName: "Apple", _itemType: UsableItem.ItemType.FOOD_APPLE, _itemCost: 0, _itemDescription: "An apple.", _itemImage: "apple"));
//        
//        drinkArray.removeAll();
//        drinkArray.append(itemObject(_itemName: "Water", _itemType: UsableItem.ItemType.DRINK_WATER, _itemCost: 0, _itemDescription: "The most basic of drinks.", _itemImage: "water"));
////        drinkArray.append(itemObject(_itemName: "Juice", _itemType: GameScene.ItemType.DRINK_JUICE, _itemCost: 0, _itemDescription: "It's the quenchiest!", _itemImage: "juice"));
//        
//        toysArray.removeAll();
//        toysArray.append(itemObject(_itemName: "Toy Ball", _itemType: UsableItem.ItemType.TOY_BALL, _itemCost: 0, _itemDescription: "Throw the ball.", _itemImage: "ball"));
    }
}
