//
//  GameViewController_ItemBagEXT.swift
//  Crealings
//
//  Created by Amber Miller on 3/15/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import UIKit

extension GameViewController {
    
    func hideItemBag () {
        println("Hide Bag");

        (skView.scene as GameScene).itemBagIsHidden = true;
        
        item_shelf.hidden = true;
        collection1.hidden = true;
        collection2.hidden = true;
        collection3.hidden = true;
    }
    
    func showItemBag () {
        if (loadData()) {
            println("Show Bag");

            item_shelf.hidden = false;
            collection1.hidden = false;
            collection2.hidden = false;
            collection3.hidden = false;
        }
    }
    
    func loadData () -> Bool {
        foodArray.removeAll();
        foodArray.append(itemObject(_itemName: "Apple", _itemType: GameScene.ItemType.FOOD_APPLE, _itemCost: 0, _itemDescription: "An apple.", _itemImage: "apple"));
        collection1.reloadData();
        
        drinkArray.removeAll();
        drinkArray.append(itemObject(_itemName: "Water", _itemType: GameScene.ItemType.DRINK_WATER, _itemCost: 0, _itemDescription: "The most basic of drinks.", _itemImage: "water"));
        //        drinkArray.append(itemObject(_itemName: "Juice", _itemType: GameScene.ItemType.DRINK_JUICE, _itemCost: 0, _itemDescription: "It's the quenchiest!", _itemImage: "juice"));
        collection2.reloadData();
        
        toysArray.removeAll();
        toysArray.append(itemObject(_itemName: "Toy Ball", _itemType: GameScene.ItemType.TOY_BALL, _itemCost: 0, _itemDescription: "Throw the ball.", _itemImage: "ball"));
        collection3.reloadData();
        
        return true;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: itemCell = itemCell();
        var item: itemObject? = nil;
        
        println("Collection View: \(collectionView)");
        println("Food Array: \(foodArray)");
        println("Drink Array: \(drinkArray)");
        println("Toys Array: \(toysArray)");

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
            cell.itemImage.image = item!.itemImage;
        }
        
        let height: CGFloat = collectionView.frame.height - 10.0;
        cell.frame.size = CGSizeMake(height, height);
        cell.center.y = collectionView.frame.size.height / 2;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("Collection View: \(collectionView)");
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
        var item: itemObject? = nil;
        
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
        println("Collection: \(view) Selected Item: \(item?.itemName)");
    }
}
