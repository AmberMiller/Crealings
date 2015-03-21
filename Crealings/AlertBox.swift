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
    var toStartButton: SKSpriteNode? = nil;
    
    func setup (view: GameScene) -> Bool {
        self.position = CGPointMake(view.size.width / 2, view.size.height / 2);
        self.zPosition = 2;
        
        alertSprite = SKSpriteNode(imageNamed: "game_over");
        
        let ratio: CGFloat = alertSprite!.size.width / alertSprite!.size.height;
        let newViewWidth: CGFloat = view.size.width / 2;
        let ratioHeight: CGFloat = newViewWidth / ratio;
        alertSprite?.size = CGSizeMake(newViewWidth, ratioHeight);
        
        toStartButton = SKSpriteNode();
        toStartButton?.zPosition = 2;
        toStartButton?.size = CGSizeMake(alertSprite!.size.width / 3.4, alertSprite!.size.height / 5);
        toStartButton?.position = CGPointMake(0.0, -alertSprite!.size.height / 4);
        toStartButton?.name = "toStart";
        
        alertSprite?.addChild(toStartButton!);
        self.addChild(alertSprite!);
        
        return true;
    }
    
}
