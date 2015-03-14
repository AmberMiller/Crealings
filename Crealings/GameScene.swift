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
    func MenuButtonClicked();
    func FightButtonClicked();
}

class GameScene: SKScene {
    
    class var sharedInstance: GameScene {
        
        struct gameScene {
            
            static let instance: GameScene = GameScene()
        }
        
        return gameScene.instance
    }
    
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
        case FOOD_BROCOLLI
        case DRINK_WATER
        case DRINK_JUICE
        case TOY_BALL
        case TOY_BOOK
    }
    
    var gameDelegate: GameSceneDelegate?;

    var currentMon: String? = nil;
    
    var gameHUD: GameHUD? = nil;
    
    var crealing: Crealing? = nil;
        
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameDelegate?.GameSceneSetup();
    }
    
    func refresh () {
        if (crealing != nil && gameHUD!.refresh()) {
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
                case "HUD":
                    println("HUD Tapped");
                case "menu":
                    println("Tap Menu");
                    gameDelegate?.MenuButtonClicked();
                case "shop":
                    println("Tap Shop");
                case "fight":
                    println("Tap Fight");
                case "coin":
                    println("Tap Coin");
                case "gem":
                    println("Tap Gem");
                case "exp":
                    println("Tap Exp");
                case "help":
                    println("Tap Help");
                case "happiness":
                    println("Tap Happiness");
                    checkMood();
                case "energy":
                    println("Tap Energy");
                    checkMood();
                case "hunger":
                    println("Tap Hunger");
                    //TODO Set food type dynamically
                    if (gameHUD != nil && crealing!.feedPet(ItemType.FOOD_APPLE)) {
                        gameHUD!.feed();
                    }
                    checkMood();
                case "thirst":
                    println("Tap Thirst");
                    if (gameHUD != nil && crealing!.hydratePet(ItemType.DRINK_JUICE)) {
                        gameHUD!.hydrate();
                    }
                    checkMood();
                case "fun":
                    println("Tap Fun");
                    if (gameHUD != nil && crealing!.playWith(ItemType.TOY_BALL)) {
                        gameHUD!.play();
                    }
                    checkMood();
                case "hygiene":
                    println("Tap Hygiene");
                    if (gameHUD != nil && crealing!.cleanPet()) {
                        gameHUD?.bathe();
                    }
                    checkMood();
                default:
                    break;
                }
            }
            break;
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
//        var bg: SKSpriteNode = SKSpriteNode(imageNamed: "background1");
//        bg.zPosition = -2;
//        bg.position = CGPointMake(self.size.width / 2, self.size.height / 2);
//        self.addChild(bg);
        
        /* Setup game menu */
        gameHUD = GameHUD(imageNamed: "main_hud");
        gameHUD?.position = CGPointMake(0.0, self.frame.height);
        let ratio: CGFloat = 682.666687011719 / 62; //Get original aspect ratio of image
        let HUDHeight: CGFloat = self.size.width / ratio; //Set height with aspect ratio
        gameHUD?.size = CGSizeMake(self.size.width, HUDHeight); //Set menu size to width of screen
        
        if ((gameHUD != nil) && (gameHUD!.setupHUD())) {
            self.addChild(self.gameHUD!);
        }
        
        println("GAME SIZE: \(self.frame.size) HUD SIZE: \(gameHUD?.frame.size)");
        
        /* Add crealing to scene */
        crealing = Crealing();
        if (currentMon != nil) {
            if ((crealing != nil) && (crealing!.setup(self, mon: currentMon!))) {
                self.addChild(crealing!);
            }
        }
        
        //For Testing Purposes Only - Change stats every 10 secs
        let timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: ("refresh"), userInfo: nil, repeats: true);
    }
    
    /* Get crealing mood and set respectively */
    func checkMood () {
        if (crealing != nil) {
            crealing!.setMood(crealing!.getMood());
        }
    }
}
