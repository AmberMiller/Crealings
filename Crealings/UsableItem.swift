//
//  DraggableItem.swift
//  Crealings
//
//  Created by Amber Miller on 3/17/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class UsableItem: SKNode {
    
    enum ItemType: UInt32 {
        case FOOD_APPLE = 0
        case FOOD_CHOCOLATE
        case FOOD_BROCOLLI
        case DRINK_WATER
        case DRINK_JUICE
        case TOY_BALL
        case TOY_BOOK
    }
    
    var gameScene: GameScene = GameScene.sharedInstance;

    var newItem: SKSpriteNode? = nil;
    
    /* Add usable item to the GameScene with image based on chosen item */
    func addItem (item: Dictionary <String, AnyObject>, tapPosition: CGPoint) {
        let itemName = item["imageName"] as! String;
        println("Add Item Name: \(itemName)")
        newItem = SKSpriteNode(imageNamed: itemName);
        newItem?.size = CGSizeMake(newItem!.size.width / 1.5, newItem!.size.height / 1.5);
        newItem?.zPosition = 6;
        
        println("Position: \(tapPosition)");
        self.position = tapPosition;
        self.physicsBody = SKPhysicsBody(circleOfRadius: newItem!.size.width / 2);
        self.physicsBody?.allowsRotation = true;
        self.physicsBody?.dynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.categoryBitMask = GameScene.CollisionType.ITEM.rawValue;
        self.physicsBody?.contactTestBitMask = GameScene.CollisionType.CREALING.rawValue;
        self.physicsBody?.collisionBitMask = GameScene.CollisionType.FLOOR.rawValue;
        
        self.addChild(newItem!);
        
        gameScene.addedItem = true;
    }
    
    
}
