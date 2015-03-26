//
//  GameScene.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSceneDelegate {
    func GameSceneSetup();
    func MenuButtonClicked();
    func FightButtonClicked();
    func clearGame();
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    class var sharedInstance: GameScene {
        
        struct gameScene {
            
            static let instance: GameScene = GameScene()
        }
        
        return gameScene.instance
    }
    
    enum UIUserInterfaceIdiom : Int {
        case Unspecified
        
        case Phone // iPhone and iPod touch style UI
        case Pad // iPad style UI
    }
    
    enum CollisionType: UInt32 {
        case CREALING = 0
        case ITEM
        case FLOOR
    }
    
    var gameDelegate: GameSceneDelegate?;
    var gameData: GameData = GameData.sharedInstance;
    let status: Status = Status.sharedInstance;
    var gameView: SKView = SKView();
    
    var isNewGame: Bool = Bool();
    var currentMon: String? = nil;
    
    var gameHUD: GameHUD? = nil;
    var bg: SKSpriteNode? = nil;
    var crealing: Crealing? = nil;
    var itemBag: ItemBag? = nil;
    var usableItem: UsableItem? = nil;
    var shopHUD: ShopHUD? = nil;
    var alertBox: AlertBox? = nil;
    var helpScreen: HelpScreen? = nil;
    
    var userCoins: Int = Int();
    
    var touching: Bool = Bool();
    var touchLength: NSTimeInterval = 0;
    var tapLocation: CGPoint = CGPoint();
    var addedItem: Bool = Bool();
    var isItem: Bool = Bool();
    var selectedNodeName: String = String();
    var usableItemDict: Dictionary <String, AnyObject>? = nil;
    var itemHovering: Bool = Bool();
    var itemShopOpen: Bool = Bool();
    
    var timeSinceLastCoinDrop: NSTimeInterval = 0;
    var refreshRate: NSTimeInterval = 0;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameDelegate?.GameSceneSetup();
        gameView = view;
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
            var lastUpdate: NSTimeInterval = NSTimeInterval();
            var timeSinceLast: CFTimeInterval = currentTime - lastUpdate;
            lastUpdate = currentTime;
        
            /* If frame rate drops, keep ratio */
            if (timeSinceLast > 1) {
                timeSinceLast = 1.0 / 60.0;
                lastUpdate = currentTime;
            }
        
        /* Testing Purposes Only: Refresh stats */
        refreshRate += timeSinceLast;
        
        if (refreshRate > 6.0) {
            refresh();
            refreshRate = 0;
        }
        
        /* Random Coins */

        if (crealing != nil && status.getMoodTotal() > 65) {
            timeSinceLastCoinDrop += timeSinceLast;
        
            let randomTime: Double = Double(arc4random_uniform(10) + 3);
            if (timeSinceLastCoinDrop > randomTime) {
                let coinsGiven = Int(arc4random_uniform(5) + 1);
                var coinDrop: SKSpriteNode = SKSpriteNode();
                switch coinsGiven {
                    case 1:
                        coinDrop = SKSpriteNode(imageNamed: "plus1coin");
                    case 2:
                        coinDrop = SKSpriteNode(imageNamed: "plus2coin");
                    case 3:
                        coinDrop = SKSpriteNode(imageNamed: "plus3coin");
                    case 4:
                        coinDrop = SKSpriteNode(imageNamed: "plus4coin");
                    case 5:
                        coinDrop = SKSpriteNode(imageNamed: "plus5coin");
                    default:
                        println("Coins Given: \(coinsGiven)");
                }
                coinDrop.position = CGPointMake(self.size.width / 2, self.size.height / 2.5);
                coinDrop.zPosition = 3;
                coinDrop.alpha = 0.0;
                self.addChild(coinDrop);

                let coinAction = SKAction.sequence ([
                    SKAction.fadeInWithDuration(0.4),
                    SKAction.moveBy(CGVectorMake(0.0, 30.0), duration: 1.0),
                    SKAction.fadeOutWithDuration(0.6),
                    SKAction.removeFromParent()
                ]);
                coinDrop.runAction(coinAction);
                timeSinceLastCoinDrop = 0;
                
                userCoins = gameData.getUserCoins();
                userCoins += coinsGiven;
                gameData.writeData(userCoins, key: "userCoins");
                gameHUD!.setCoinsAmount(userCoins);
                gameData.loadData();
            }
        }

        /* Long Press */
        if (touching) { //If user is holding tap

            touchLength += timeSinceLast; //Track touch length
            
            
            if (touchLength > 0.2 //If long press last more than 2 seconds
                && !addedItem //Prevents multiple items
                && isItem //Make sure user pressed an item node on shelf
                && (itemBag != nil) //Make sure itemBag is "open"
                && usableItemDict != nil) //Make sure item dictionary is not nil
            {
                if (usableItemDict!["isConsumable"] as Bool) {
                    /* Create and add item based on current location */
                    usableItem = UsableItem();
                    usableItem?.zPosition = 1;
                    usableItem!.addItem(usableItemDict!, tapPosition: tapLocation);
                    self.addChild(usableItem!);
                    closeBag(); //Close the bag
                }
            }
        }
    }
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setUpScene () {
        gameData.loadData();
        
        println("isNewGame: \(isNewGame)");
        if (isNewGame) {
            status.resetData();
        }
        
        /* Set physicsWorld */
        physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0, -3.0);
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.physicsBody!.categoryBitMask = CollisionType.FLOOR.rawValue;
        self.physicsBody!.contactTestBitMask = CollisionType.ITEM.rawValue;
        view?.showsPhysics = true; //Show physics bounds
        
        /* Add background to scene */
        let bgName: String = gameData.getBackground();
        bg = SKSpriteNode(imageNamed: bgName);
        bg!.zPosition = -1; //Make sure is behind
        bg!.size = CGSizeMake(self.size.width, getRatioHeight(bg!.size.width, height: bg!.size.height)); //Keep ratio
        bg!.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        self.addChild(bg!);
        
        /* Add game menu to scene */
        gameHUD = GameHUD.sharedInstance;
        if (gameHUD!.setupHUD(self)) {
            userCoins = gameData.getUserCoins();
            gameHUD!.setCoinsAmount(userCoins);
            self.addChild(self.gameHUD!);
        }
        
        println("GAME SIZE: \(self.frame.size) HUD SIZE: \(gameHUD!.frame.size)");
        
        /* Add crealing to scene */
        crealing = Crealing();
        crealing!.name = "crealing";
        if (currentMon != nil) {
            if ((crealing != nil) && (crealing!.setup(self, mon: currentMon!))) {
                self.addChild(crealing!);
            }
        }
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
    
    /* Open/Close shop bar */
    func shopButtonClicked () {
        if (shopHUD == nil) {
            shopHUD = ShopHUD();
            shopHUD?.zPosition = 2;
            if (shopHUD!.setup(self, skView: gameView)) {
                itemShopOpen = true;
                self.addChild(shopHUD!);
                shopHUD?.animateIn();
            }
        } else {
            if (shopHUD!.animateOut()) {
                itemShopOpen = false;
                shopHUD = nil;
            }
        }
    }
    
    /* Open/Close help screen */
    func helpButtonClicked () {
        if (helpScreen == nil) {
            helpScreen = HelpScreen();
            helpScreen?.zPosition = 5;
            
            if (helpScreen!.setup(self)) {
                self.addChild(helpScreen!);
            }
        } else {
            helpScreen?.removeFromParent();
            helpScreen = nil;
        }
    }
}
