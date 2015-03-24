//
//  ShopHUD.swift
//  Crealings
//
//  Created by Amber Miller on 3/23/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class ShopHUD: SKSpriteNode {
    
    var foodArray: [Dictionary <String, AnyObject>] = [];
    var drinkArray: [Dictionary <String, AnyObject>] = [];
    var toysArray: [Dictionary <String, AnyObject>] = [];
    
    var gameData: GameData = GameData.sharedInstance;
    
    var gameView: GameScene? = nil;
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setup (view: GameScene) -> Bool {
        gameView = view;
        
        self.anchorPoint = CGPointMake(0.5, 0.0);
        self.color = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
        self.size = CGSizeMake(gameView!.size.width, gameView!.size.height / 1.4);
        self.position = CGPointMake(gameView!.size.width / 2, -gameView!.size.height);
        self.zPosition = 2;
        
        
        if (loadData()) {
            addItems(foodArray);
        }
        
        return true;
    }
    
    func animateIn () {
        let moveAction: SKAction = SKAction.moveTo(CGPointMake(gameView!.size.width / 2, 0.0), duration: 0.3);
        self.runAction(moveAction);
    }
    
    func animateOut () -> Bool {
        let moveAction: SKAction = SKAction.moveTo(CGPointMake(gameView!.size.width / 2, -gameView!.size.height), duration: 0.3);
        let sequence: SKAction = SKAction.sequence([
            moveAction,
            SKAction.removeFromParent()
        ]);
        self.runAction(moveAction);
        
        return true;
    }
    
    func loadData () -> Bool {
        if (gameData.loadData()) {
            foodArray = gameData.getFoodItemsArray();
            drinkArray = gameData.getDrinkItemsArray();
            toysArray = gameData.getToyItemsArray();
        }
        
        return true;
    }
    
    func addItems (currentArray: [Dictionary <String, AnyObject>]) {
        for (var i = 0; i < currentArray.count; i++) {
            let currentItem: Dictionary <String, AnyObject> = currentArray[i];
            
            let itemBox: SKSpriteNode = SKSpriteNode(imageNamed: "itemBox");
            
            let ratio: CGFloat = itemBox.size.width / itemBox.size.height;
            let height: CGFloat = self.size.height / 1.6;
            let ratioWidth: CGFloat = height / ratio;
            itemBox.size = CGSizeMake(height, ratioWidth);
            itemBox.position = CGPointMake(-self.size.width / 2.7, self.size.height / 1.55);
            itemBox.zPosition = 3;
            
            self.addChild(itemBox);
        }
    }
}
