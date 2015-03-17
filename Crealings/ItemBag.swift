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
    
    var foodArray: [itemObject] = [];
    var drinkArray: [itemObject] = [];
    var toysArray: [itemObject] = [];
    var selectedCell: Int = Int();
    
    var itemShelf: SKSpriteNode? = nil;
    
    var collection1: SKSpriteNode? = nil;
    var collection2: SKSpriteNode? = nil;
    var collection3: SKSpriteNode? = nil;
    
    var itemBagIsHidden: Bool = true;
    
    func setup (view: GameScene) {
        loadData();
        self.position = CGPointMake(view.size.width / 2, view.size.height / 2.3);
        
        itemShelf = SKSpriteNode(imageNamed: "shop_shelf");
        
        let ratio: CGFloat = itemShelf!.size.width / itemShelf!.size.height;
        let newViewHeight: CGFloat = view.size.width / 1.3;
        let ratioHeight: CGFloat = newViewHeight / ratio;
        itemShelf?.size = CGSizeMake(newViewHeight, ratioHeight);
        
        collection1 = SKSpriteNode();
        collection1?.anchorPoint = CGPointMake(0.0, 0.0);
        collection1?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection1?.position = CGPointMake(-itemShelf!.size.width / 2.21, itemShelf!.size.height / 6);
        collection1?.zPosition = 2;
        
        addChildren(collection1!, currentArray: foodArray);
        itemShelf?.addChild(collection1!);
        

        collection2 = SKSpriteNode();
        collection2?.anchorPoint = CGPointMake(0.0, 0.0);
        collection2?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection2?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 7.3);
        collection2?.zPosition = 2;
        
        addChildren(collection2!, currentArray: drinkArray);
        itemShelf?.addChild(collection2!);
        
        
        collection3 = SKSpriteNode();
        collection3?.color = UIColor.blackColor();
        collection3?.alpha = 0.5;
        collection3?.anchorPoint = CGPointMake(0.0, 0.0);
        collection3?.size = CGSizeMake(itemShelf!.size.width / 1.11, itemShelf!.size.height / 3.9);
        collection3?.position = CGPointMake(-itemShelf!.size.width / 2.21, -itemShelf!.size.height / 2.33);
        collection3?.zPosition = 2;
        
        addChildren(collection3!, currentArray: toysArray);
        itemShelf?.addChild(collection3!);
        
        self.addChild(itemShelf!);
    }
    
    func addChildren (collection: SKSpriteNode, currentArray: [itemObject]) {
        for (var i = 0; i < currentArray.count; i++) {
            let object: itemObject = currentArray[i];
            var item: SKSpriteNode = SKSpriteNode(imageNamed: object.itemImageName);
            item.name = object.itemName;
            item.anchorPoint = CGPointMake(0.0, 0.0);
            item.size = CGSizeMake(collection1!.size.height, collection1!.size.height);
            
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
    
    func loadData () -> Bool {
        foodArray.removeAll();
        foodArray.append(itemObject(_itemName: "Apple", _itemType: GameScene.ItemType.FOOD_APPLE, _itemCost: 0, _itemDescription: "An apple.", _itemImage: "apple"));
        foodArray.append(itemObject(_itemName: "Chocolate", _itemType: GameScene.ItemType.FOOD_CHOCOLATE, _itemCost: 0, _itemDescription: "CHOCOLATE!!!", _itemImage: "ball"));
        
        drinkArray.removeAll();
        drinkArray.append(itemObject(_itemName: "Water", _itemType: GameScene.ItemType.DRINK_WATER, _itemCost: 0, _itemDescription: "The most basic of drinks.", _itemImage: "water"));
        //        drinkArray.append(itemObject(_itemName: "Juice", _itemType: GameScene.ItemType.DRINK_JUICE, _itemCost: 0, _itemDescription: "It's the quenchiest!", _itemImage: "juice"));
        
        toysArray.removeAll();
        toysArray.append(itemObject(_itemName: "Toy Ball", _itemType: GameScene.ItemType.TOY_BALL, _itemCost: 0, _itemDescription: "Throw the ball.", _itemImage: "ball"));
        
        return true;
    }
}