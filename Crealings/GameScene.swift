//
//  GameScene.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate {
    func GameSceneSetup();
}

class GameScene: SKScene {
    
    enum Mood: UInt32 {
        case VERY_HAPPY = 0
        case MORE_HAPPY
        case HAPPY
        case NEUTRAL
        case UNHAPPY
        case SAD
        case VERY_SAD
        case DYING
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
    
    var gameDelegate: GameSceneDelegate?;

    var currentMon: String? = nil;
    
    var happinessBar: StatusBar? = nil;
    var energyBar: StatusBar? = nil;
    var hungerBar: StatusBar? = nil;
    var thirstBar: StatusBar? = nil;
    var funBar: StatusBar? = nil;
    var hygieneBar: StatusBar? = nil;
    
    var status: Status = Status.sharedInstance;

    var crealing: Crealing? = nil;
        
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameDelegate?.GameSceneSetup();
    }
    
    func refresh () {
        happinessBar?.setStatus(status.setHappiness(-10));
        energyBar?.setStatus(status.setEnergy(-10));
        hungerBar?.setStatus(status.setHunger(-10));
        thirstBar?.setStatus(status.setThirst(-10));
        funBar?.setStatus(status.setFun(-10));
        hygieneBar?.setStatus(status.setHygiene(-10));
        if (crealing != nil) {
            crealing!.setMood(crealing!.getMood());
        }
    }
    
    /***********************************************************
        Touches
    ************************************************************/
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            if (node.name != nil) {
                switch node.name! {
                case "crealing":
                    crealing?.tapPet();
                case "happiness":
                    happinessBar?.tapStatusBar("happiness");
                case "energy":
                    energyBar?.tapStatusBar("energy");
                case "hunger":
                    hungerBar?.tapStatusBar("hunger");
                case "thirst":
                    thirstBar?.tapStatusBar("thirst");
                case "fun":
                    funBar?.tapStatusBar("fun");
                case "hygiene":
                    hygieneBar?.tapStatusBar("hygiene");
                default:
                    break;
                }
                
                if (crealing != nil) {
                    crealing!.setMood(crealing!.getMood());
                }
            }
        }
    }
    
    /***********************************************************
        Update
    ************************************************************/
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setUpScene () {
        var bg: SKSpriteNode = SKSpriteNode(imageNamed: "background1");
        bg.zPosition = -2;
        bg.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        self.addChild(bg);
        
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
        
        crealing = Crealing();
        if (currentMon != nil) {
            if ((crealing != nil) && (crealing!.setup(self, mon: currentMon!))) {
                self.addChild(crealing!);
            }
        }
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: ("refresh"), userInfo: nil, repeats: true);
        
    }
}
