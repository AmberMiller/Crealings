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
    
    var menuButton: SKSpriteNode? = nil;
    var shopButton: SKSpriteNode? = nil;
    var fightButton: SKSpriteNode? = nil;
    var coinBar: SKSpriteNode? = nil;
    var gemBar: SKSpriteNode? = nil;
    var expBar: SKSpriteNode? = nil;
    var helpButton: SKSpriteNode? = nil;
    
    var happinessBar: StatusBar? = nil;
    var energyBar: StatusBar? = nil;
    var hungerBar: StatusBar? = nil;
    var thirstBar: StatusBar? = nil;
    var funBar: StatusBar? = nil;
    var hygieneBar: StatusBar? = nil;
    
    var itemBagButton: SKSpriteNode? = nil;
    
    //For testing purposes, decrease each status by 10 every 10 seconds
    func refresh () -> Bool {
        happinessBar?.setStatus(status.setHappiness(-10));
        energyBar?.setStatus(status.setEnergy(-10));
        hungerBar?.setStatus(status.setHunger(-10));
        thirstBar?.setStatus(status.setThirst(-10));
        funBar?.setStatus(status.setFun(-10));
        hygieneBar?.setStatus(status.setHygiene(-10));
        
        return true;
    }
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setupHUD () -> Bool {
        self.anchorPoint = CGPointMake(0.0, 1.0);
        
        /* Menu Buttons */
        menuButton = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(self.size.width / 9, self.size.height / 2));
        menuButton?.position = CGPointMake(0.0, 0.0);
        menuButton?.anchorPoint = CGPointMake(0.0, 1.0);
        menuButton?.name = "menu";
        self.addChild(menuButton!);
        
        shopButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.size.width / 8.1, self.size.height / 2));
        shopButton?.position = CGPointMake(self.size.width / 8.4, 0.0);
        shopButton?.anchorPoint = CGPointMake(0.0, 1.0);
        shopButton?.name = "shop"
        self.addChild(shopButton!);
        
        /* Not using in game for class */
        
//        fightButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(self.size.width / 8, self.size.height / 2));
//        fightButton?.position = CGPointMake(self.size.width / 3.95, 0.0);
//        fightButton?.anchorPoint = CGPointMake(0.0, 1.0);
//        fightButton?.name = "fight";
//        self.addChild(fightButton!);
//        
//        coinBar = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.size.width / 6, self.size.height / 2));
//        coinBar?.position = CGPointMake(self.size.width / 2.45, 0.0);
//        coinBar?.anchorPoint = CGPointMake(0.0, 1.0);
//        coinBar?.name = "coin";
//        self.addChild(coinBar!);
//        
//        gemBar = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(self.size.width / 6, self.size.height / 2));
//        gemBar?.position = CGPointMake(self.size.width / 1.68, 0.0);
//        gemBar?.anchorPoint = CGPointMake(0.0, 1.0);
//        gemBar?.name = "gem";
//        self.addChild(gemBar!);
//        
//        expBar = SKSpriteNode(color: UIColor(red: 0.447, green: 0.447, blue: 0.447, alpha: 1.0),
//                              size: CGSizeMake(self.size.width / 6, self.size.height / 2));
//        expBar?.position = CGPointMake(self.size.width / 1.26, 0.0);
//        expBar?.anchorPoint = CGPointMake(0.0, 1.0);
//        expBar?.name = "exp";
//        self.addChild(expBar!);
        
//        vec4 color = mix(vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), v_tex_coord.y);
//        gl_FragColor = color;
        //gradient color for exp bar
        
        helpButton = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(self.size.width / 12, self.size.height / 2));
        helpButton?.position = CGPointMake(self.size.width / 1.045, 0.0);
        helpButton?.anchorPoint = CGPointMake(0.0, 1.0);
        helpButton?.name = "help";
        self.addChild(helpButton!);
        
        /* Status Bars */ //Calls StatusBar setup for each status
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
        
        /* Item Bag Button */
        itemBagButton = SKSpriteNode(imageNamed: "bag_button");
        itemBagButton?.anchorPoint = CGPointMake(1.0, 1.0);
        itemBagButton?.position = CGPointMake(self.size.width - 10.0, -self.size.height * 4.5);
        itemBagButton?.name = "bag";
        self.addChild(itemBagButton!);
        
        return true;
    }
    
    
    /***********************************************************
        Interactions
    ************************************************************/
    
    func interactWith () {
        happinessBar?.setStatusBar("happiness");
        energyBar?.setStatusBar("energy");
        hungerBar?.setStatusBar("hunger");
        thirstBar?.setStatusBar("thirst");
        funBar?.setStatusBar("fun");
        hygieneBar?.setStatusBar("hygiene");
    }
}
