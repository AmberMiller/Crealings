//
//  ItemBag.swift
//  Crealings
//
//  Created by Amber Miller on 3/15/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit
import UIKit

class ItemBag: SKNode {
 
    var gameScene: GameScene = GameScene.sharedInstance;
    var gameData: GameData = GameData();
    
    var foodArray: [Dictionary <String, AnyObject>] = [];
    var drinkArray: [Dictionary <String, AnyObject>] = [];
    var toysArray: [Dictionary <String, AnyObject>] = [];
    var selectedCell: Int = Int();
    
    var itemShelf: SKSpriteNode? = nil;
    
    var collection1: SKSpriteNode? = nil;
    var collection2: SKSpriteNode? = nil;
    var collection3: SKSpriteNode? = nil;
    
    var itemBagIsHidden: Bool = true;
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setup (view: GameScene) {
        loadData();
        self.position = CGPointMake(view.size.width / 2, view.size.height / 2.3);
        
        itemShelf = SKSpriteNode(imageNamed: "shop_shelf");
        
        let ratio: CGFloat = itemShelf!.size.width / itemShelf!.size.height;
        let newViewHeight: CGFloat = view.size.width / 1.3;
        let ratioHeight: CGFloat = newViewHeight / ratio;
        itemShelf?.size = CGSizeMake(newViewHeight, ratioHeight);
        
        /* Add node to first shelf */
        collection1 = SKSpriteNode();
        collection1?.anchorPoint = CGPointMake(0.0, 0.0);
        collection1?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection1?.position = CGPointMake(-itemShelf!.size.width / 2.21, itemShelf!.size.height / 6);
        collection1?.zPosition = 2;
        
        addChildren(collection1!, currentArray: foodArray); //Add food to shelf node
        itemShelf?.addChild(collection1!);
        
        /* Add node to second shelf */
        collection2 = SKSpriteNode();
        collection2?.anchorPoint = CGPointMake(0.0, 0.0);
        collection2?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection2?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 7.3);
        collection2?.zPosition = 2;
        
        addChildren(collection2!, currentArray: drinkArray); //Add drink to shelf node
        itemShelf?.addChild(collection2!);
        
        /* Add node to third shelf */
        collection3 = SKSpriteNode();
        collection3?.anchorPoint = CGPointMake(0.0, 0.0);
        collection3?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection3?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 2.33);
        collection3?.zPosition = 2;
        
        addChildren(collection3!, currentArray: toysArray); //Add toys to shelf node
        itemShelf?.addChild(collection3!);
        
        self.addChild(itemShelf!);
    }
    
    /***********************************************************
        Adding Items
    ************************************************************/
    
    /* Loop through current array and add each object to current shelf node */
    func addChildren (collection: SKSpriteNode, currentArray: [Dictionary <String, AnyObject>]) {
        for (var i = 0; i < currentArray.count; i++) {
            let object: Dictionary <String, AnyObject> = currentArray[i];
            let itemName = object["imageName"] as String;
            var item: SKSpriteNode = SKSpriteNode(imageNamed: itemName);
            item.name = itemName;
            item.anchorPoint = CGPointMake(0.0, 0.0);
            item.size = CGSizeMake(collection.size.height, collection.size.height);
            
            //Set position based on current number in array plus extra spacing after the first object
            let currentNum: CGFloat = CGFloat(i);
            let currentPosition: CGFloat = item.size.width * currentNum;
            var space: CGFloat?;
            
            if (i == 0) {
                space = 0.0;
            } else {
                space = item.size.width / 4;
            }
            
            item.position = CGPointMake(currentPosition + space!, 0.0);
            
            collection.addChild(item);
        }
    }
    
    /***********************************************************
        Passing Data if Exists
    ************************************************************/
    
    /* Loop through each array and check if nodeName matches any of the items */
    func getItemDict (nodeName: String) -> Dictionary <String, AnyObject>? {
        
        for item in foodArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        
        for item in drinkArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        
        for item in toysArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        return nil;
    }
    
    /***********************************************************
        Set item data from gameData
    ************************************************************/
    func loadData () -> Bool {
        gameData.loadData();
        
        foodArray = gameData.getFoodItemsArray();
        drinkArray = gameData.getDrinkItemsArray();
        toysArray = gameData.getToyItemsArray();
        
        return true;
    }
}