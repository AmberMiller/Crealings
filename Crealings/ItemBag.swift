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
    var gameData: GameData = GameData.sharedInstance;
    
    var foodDrinksArray: [Dictionary <String, AnyObject>] = [];
    var careArray: [Dictionary <String, AnyObject>] = [];
    var decorationsArray: [Dictionary <String, AnyObject>] = [];
    var selectedCell: Int = Int();
    
    var itemShelf: SKSpriteNode? = nil;
    
    var scrollTest: JADSKScrollingNode = JADSKScrollingNode();
    var collection1: SKSpriteNode? = nil;
    var collection2: SKSpriteNode? = nil;
    var collection3: SKSpriteNode? = nil;
    
    var itemBagIsHidden: Bool = true;
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setup (view: GameScene, gameView: UIView) {
        loadData();
        
        self.position = CGPointMake(view.size.width / 2, view.size.height / 2.3);
        self.zPosition = 3;
        
        itemShelf = SKSpriteNode(imageNamed: "shop_shelf");
        
        let ratio: CGFloat = itemShelf!.size.width / itemShelf!.size.height;
        let newViewWidth: CGFloat = view.size.width / 1.3;
        let ratioHeight: CGFloat = newViewWidth / ratio;
        itemShelf?.size = CGSizeMake(newViewWidth, ratioHeight);

//        scrollTest.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
//        scrollTest.position = CGPointMake(-itemShelf!.size.width / 2.21, itemShelf!.size.height / 6);
//        scrollTest.zPosition = 2;
//        scrollTest.enableScrollingOnView(gameView);
        
        /* Add node to first shelf */
        collection1 = SKSpriteNode();
        collection1?.anchorPoint = CGPointMake(0.0, 0.0);
        collection1?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection1?.position = CGPointMake(-itemShelf!.size.width / 2.21, itemShelf!.size.height / 6);
        collection1?.zPosition = 2;
        
        addChildren(collection1!, currentArray: foodDrinksArray); //Add food and drinks to shelf node
        itemShelf?.addChild(collection1!);
        
        /* Add node to second shelf */
        collection2 = SKSpriteNode();
        collection2?.anchorPoint = CGPointMake(0.0, 0.0);
        collection2?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection2?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 7.3);
        collection2?.zPosition = 2;
        
        addChildren(collection2!, currentArray: careArray); //Add care items to shelf node
        itemShelf?.addChild(collection2!);
        
        /* Add node to third shelf */
        collection3 = SKSpriteNode();
        collection3?.anchorPoint = CGPointMake(0.0, 0.0);
        collection3?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection3?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 2.33);
        collection3?.zPosition = 2;
        
        addChildren(collection3!, currentArray: decorationsArray); //Add decorations to shelf node
        itemShelf?.addChild(collection3!);
        
        self.addChild(itemShelf!);
    }
    
//    func reloadData () {
//        collection1?.removeAllChildren();
//        addChildren(collection1!, currentArray: foodDrinksArray); //Add food and drinks to shelf node
//
//        collection2?.removeAllChildren();
//        addChildren(collection2!, currentArray: careArray); //Add care items to shelf node
//
//        collection3?.removeAllChildren();
//        addChildren(collection3!, currentArray: decorationsArray); //Add decorations to shelf node
//    }
    
    /***********************************************************
        Adding Items
    ************************************************************/
    
    /* Loop through current array and add each object to current shelf node */
    func addChildren (collection: SKSpriteNode, currentArray: [Dictionary <String, AnyObject>]) {
        for (var i = 0; i < currentArray.count; i++) {
            let object: Dictionary <String, AnyObject> = currentArray[i];
            let numOwned: Int = object["numOwned"] as Int;
            if (numOwned > 0) {
                let itemName = object["imageName"] as String;
                var item: SKSpriteNode = SKSpriteNode(imageNamed: itemName);
                item.name = itemName;
                item.anchorPoint = CGPointMake(0.0, 0.0);
                item.size = CGSizeMake(collection.size.height, collection.size.height);
                var position = (item.size.width + item.size.width / 6) * CGFloat(i);
                if (position == 0) {
                    position = item.size.width / 6;
                }
                item.position = CGPointMake(position, 0.0);
                
                if (object["isConsumable"] as Bool) {
                    let itemNum = SKLabelNode(fontNamed: "Courier-Bold");
                    itemNum.text = toString(numOwned);
                    itemNum.position = CGPointMake(item.size.width / 1.2, 0.0);
                    itemNum.zPosition = 2;
                    
                    item.addChild(itemNum);
                }

                collection.addChild(item);
            }
        }
    }
    
    /***********************************************************
        Passing Data if Exists
    ************************************************************/
    
    /* Loop through each array and check if nodeName matches any of the items */
    func getItemDict (nodeName: String) -> Dictionary <String, AnyObject>? {
        
        for item in foodDrinksArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        
        for item in careArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        
        for item in decorationsArray {
            if (item["imageName"] as String == nodeName) {
                return item;
            }
        }
        return nil;
    }
    
    /***********************************************************
        Set Item Data
    ************************************************************/
    func loadData () -> Bool {
        gameData.loadData(false);
        
        foodDrinksArray = gameData.getFoodAndDrinkItemsArray();
        careArray = gameData.getCareItemsArray();
        decorationsArray = gameData.getDecorationItemsArray();
        
        return true;
    }
    

}