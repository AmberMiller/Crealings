//
//  GameHUD.swift
//  Crealings
//
//  Created by Amber Miller on 3/12/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class GameHUD: SKSpriteNode {

    var gameScene: GameScene = GameScene.sharedInstance;
    var status: Status = Status.sharedInstance;
    
    var happinessBar: StatusBar? = nil;
    var energyBar: StatusBar? = nil;
    var hungerBar: StatusBar? = nil;
    var thirstBar: StatusBar? = nil;
    var funBar: StatusBar? = nil;
    var hygieneBar: StatusBar? = nil;
    
    
    func refresh () {
        happinessBar?.setStatus(status.setHappiness(-10));
        energyBar?.setStatus(status.setEnergy(-10));
        hungerBar?.setStatus(status.setHunger(-10));
        thirstBar?.setStatus(status.setThirst(-10));
        funBar?.setStatus(status.setFun(-10));
        hygieneBar?.setStatus(status.setHygiene(-10));
//        if (crealing != nil) {
//            crealing!.setMood(crealing!.getMood());
//        }
    }
    
    func setupHUD () -> Bool {
        self.anchorPoint = CGPointMake(0.0, 1.0);
        self.name = "HUD";
        
        happinessBar = StatusBar();
        if ((happinessBar != nil) && (happinessBar!.setup(self, current: "happiness"))) {
            self.addChild(happinessBar!);
        }
    
        energyBar = StatusBar();
        if ((energyBar != nil) && (energyBar!.setup(self, current: "energy"))) {
            self.addChild(energyBar!);
        }
        
        hungerBar = StatusBar();
        if ((hungerBar != nil) && (hungerBar!.setup(self, current: "hunger"))) {
            self.addChild(hungerBar!);
        }
        
        thirstBar = StatusBar();
        if ((thirstBar != nil) && (thirstBar!.setup(self, current: "thirst"))) {
            self.addChild(thirstBar!);
        }
        
        funBar = StatusBar();
        if ((funBar != nil) && (funBar!.setup(self, current: "fun"))) {
            self.addChild(funBar!);
        }
        
        hygieneBar = StatusBar();
        if ((hygieneBar != nil) && (hygieneBar!.setup(self, current: "hygiene"))) {
            self.addChild(hygieneBar!);
        }
        
        return true;
    }
    
}
