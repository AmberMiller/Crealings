//
//  AlertBox.swift
//  Crealings
//
//  Created by Amber Miller on 3/17/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit


class AlertBox: SKNode {
    
    var alertSprite: SKSpriteNode? = nil;
    
    func setup (view: GameScene, from: String, item: Dictionary <String, AnyObject>?) -> Bool {
        self.position = CGPointMake(view.size.width / 2, view.size.height / 2);
        
        if (from == "game_over") {
            alertSprite = SKSpriteNode(imageNamed: "game_over");
            
            let ratio: CGFloat = alertSprite!.size.width / alertSprite!.size.height;
            let newViewWidth: CGFloat = view.size.width / 2;
            let ratioHeight: CGFloat = newViewWidth / ratio;
            alertSprite?.size = CGSizeMake(newViewWidth, ratioHeight);
            alertSprite?.zPosition = 4;
            
            let toStartButton = SKSpriteNode();
            toStartButton.zPosition = 2;
            toStartButton.size = CGSizeMake(alertSprite!.size.width / 3.4, alertSprite!.size.height / 5);
            toStartButton.position = CGPointMake(0.0, -alertSprite!.size.height / 4);
            toStartButton.name = "toStart";
            
            alertSprite?.addChild(toStartButton);
            self.addChild(alertSprite!);
        } else {
//            alertSprite = SKSpriteNode(imageNamed: "alert_box");
//            
//            let ratio: CGFloat = alertSprite!.size.width / alertSprite!.size.height;
//            let newViewWidth: CGFloat = view.size.width / 2;
//            let ratioHeight: CGFloat = newViewWidth / ratio;
//            alertSprite?.size = CGSizeMake(newViewWidth, ratioHeight);
//            
//            if (item != nil) {
//                let imageView = SKSpriteNode(imageNamed: item!["imageName"] as String);
//                imageView.anchorPoint = CGPointMake(0.0, 1.0);
//                imageView.zPosition = 2;
//                imageView.position = CGPointMake(-alertSprite!.size.width / 2.4, alertSprite!.size.height / 2.6);
//                let width: CGFloat = alertSprite!.size.width / 4;
//                imageView.size = CGSizeMake(width, width);
//                
//                alertSprite?.addChild(imageView);
//                
//                let itemName = SKLabelNode(fontNamed: "Copperplate-Bold")
//                itemName.text = item!["name"] as String;
//                itemName.fontSize = 20;
//                itemName.position = CGPointMake(0.0, alertSprite!.size.height / 4);
//                
//                alertSprite?.addChild(itemName);
//                
//                let
//                
//                let exitButton = SKSpriteNode(imageNamed: "exit_button");
//                exitButton.zPosition = 2;
//                exitButton.position = CGPointMake(alertSprite!.size.width / 2.1, alertSprite!.size.height / 2.2);
//                exitButton.name = "exit";
//                
//                alertSprite?.addChild(exitButton);
//            }
//            
//            self.addChild(alertSprite!);
        }
        
        return true;
    }
    
}
