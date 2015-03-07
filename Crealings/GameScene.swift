//
//  GameScene.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    enum Mood: UInt32 {
        case VERY_HAPPY = 0
        case MORE_HAPPY
        case HAPPY
        case NEUTRAL
        case UNHAPPY
        case SAD
        case VERY_SAD
        case DEAD
    }
    
    enum ItemType: UInt32 {
        case FOOD_APPLE = 0
        case FOOD_CHOCOLATE
        case DRINK_WATER
        case DRINK_JUICE
        case TOY_BALL
        case TOY_BOOK
    }

    
    var crealing: Crealing? = nil;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        setUpScene()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        crealing?.tapPet();
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func setUpScene () {
        crealing = Crealing();
        if ((crealing != nil) && (crealing!.setup(self, mon: "pHatchling"))) {
            crealing!.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
            self.addChild(crealing!);
        }
    }
}
