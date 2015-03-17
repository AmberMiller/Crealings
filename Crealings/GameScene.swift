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
    func ShopButtonClicked();
    func FightButtonClicked();
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    class var sharedInstance: GameScene {
        
        struct gameScene {
            
            static let instance: GameScene = GameScene()
        }
        
        return gameScene.instance
    }
    
    enum CollisionType: UInt32 {
        case CREALING = 0
        case ITEM
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
    
    var gameDelegate: GameSceneDelegate?;
    var gameData: GameData?;

    var currentMon: String? = nil;
    
    var gameHUD: GameHUD? = nil;
    
    var crealing: Crealing? = nil;
    
    var itemBag: ItemBag? = nil;
    
    var usableItem: UsableItem? = nil;
    
    var touching: Bool = Bool();
    var touchLength: NSTimeInterval = 0;
    var tapLocation: CGPoint = CGPoint();
    var addedItem: Bool = Bool();
    var isItem: Bool = Bool();
    var selectedNodeName: String = String();
    
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
        Update
    ************************************************************/
   
     override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (touching) { //If user is holding tap
            var lastUpdate: NSTimeInterval = NSTimeInterval();
            var timeSinceLast: CFTimeInterval = currentTime - lastUpdate;
            lastUpdate = currentTime;
            
            /* If frame rate drops, keep ratio */
            if (timeSinceLast > 1) {
                timeSinceLast = 1.0 / 60.0;
                lastUpdate = currentTime;
            }
            
            touchLength += timeSinceLast; //Track touch length
            
            
            if (touchLength > 0.2 //If long pres last more than 2 seconds
                && !addedItem //Prevents multiple items
                && isItem //Make sure user pressed an item node on shelf
                && (itemBag != nil) //Make sure itemBag is "open"
                && itemBag?.getItemDict(selectedNodeName) != nil) //Make sure item dictionary is not nil
            {
                /* Create and add item based on current location */
                usableItem = UsableItem();
                usableItem!.addItem(itemBag!.getItemDict(selectedNodeName)!, tapPosition: tapLocation);
                self.addChild(usableItem!);
                closeBag(); //Close the bag
            }
        }
    }
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setUpScene () {
        gameData = GameData();
        gameData!.loadData();
        
        /* Set physicsWorld */
        physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0, -3.0);
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        view?.showsPhysics = true; //Show physics bounds
        
        
        /* Add background to scene */
        var bg: SKSpriteNode = SKSpriteNode(imageNamed: "background_bluepolka");
        bg.zPosition = -2; //Make sure is behind
        bg.size = CGSizeMake(self.size.width, getRatioHeight(bg.size.width, height: bg.size.height)); //Keep ratio
        bg.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        self.addChild(bg);
        
        /* Setup game menu */
        gameHUD = GameHUD(imageNamed: "main_hud");
        gameHUD?.position = CGPointMake(0.0, self.frame.height);
        
        gameHUD?.size = CGSizeMake(self.size.width, getRatioHeight(gameHUD!.size.width, height: gameHUD!.size.height)); //Set menu size to width of screen
        
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
    
    func getRatioHeight (width: CGFloat, height: CGFloat) -> CGFloat {
        let ratio: CGFloat = width / height; //Get original aspect ratio of image
        return (self.size.width / ratio); //Return new height with aspect ratio
    }
    
    /* Get crealing mood and set respectively */
    func checkMood () {
        if (crealing != nil) {
            crealing!.setMood(crealing!.getMood());
        }
    }
    
    /* Remove item bag shelf from scene */
    func closeBag () {
        if (itemBag != nil) {
            itemBag?.removeFromParent();
            itemBag = nil;
        }
    }
}
