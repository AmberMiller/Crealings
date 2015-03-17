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
    
    var itemBag: ItemBag? = nil;
    
    var touching: Bool = Bool();
    var touchLength: NSTimeInterval = 0;
    var tapLocation: CGPoint = CGPoint();
    var addedItem: Bool = Bool();
    var isItem: Bool = Bool();
    var selectedNodeName: String = String();
    var newItem: SKSpriteNode? = nil;
    
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
            tapLocation = touch.locationInNode(self);
            let node = nodeAtPoint(tapLocation);
            touching = true;
            touchLength = 0;
            addedItem = false;
            newItem = nil;

            println("Node Location: \(node.position)");
            let nameArray: [String] = ["crealing", "menu", "shop", "fight", "coin", "gem", "exp", "help", "happiness", "energy", "hunger", "thirst", "fun", "hygiene"];
            
            if (node.name != nil) {
                println("Node Name: \(node.name)");
                let found = find(nameArray, node.name!) != nil;
                
                if (found) {
                    closeBag();
                    isItem = false;
                    
                    switch node.name! {
                    case "crealing":
                        if (gameHUD != nil && crealing!.tapPet()) {
                            gameHUD?.pet();
                        }
                    case "menu":
                        println("Tap Menu");
                        gameDelegate?.MenuButtonClicked();
                    case "shop":
                        println("Tap Shop");
                        gameDelegate?.ShopButtonClicked();
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
                } else {
                    println("Item Shelf Tapped");
                    if (node.name == "bag") {
                        println("Tap Bag");
                        isItem = false;
                        if (itemBag != nil) {
                            itemBag?.removeFromParent();
                            itemBag = nil;
                            break;
                        } else {
                            itemBag = ItemBag();
                            itemBag?.setup(self)
                            self.addChild(itemBag!);
                            break;
                        }
                    } else {
                        isItem = true;
                        selectedNodeName = node.name!;
                    }
                }
            }
        }
    }
    
    override func touchesMoved (touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            println("Node Location Moved: \(node.position)");
            
            if (newItem != nil) {
                newItem?.position = location;
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("Touch Length: \(touchLength)");
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            touching = false;
            
            if (newItem != nil) {
                newItem?.physicsBody?.dynamic = true;
            }
        }
    }
    
    /***********************************************************
        Update
    ************************************************************/
   
     override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (touching) {
            var lastUpdate: NSTimeInterval = NSTimeInterval();
            var timeSinceLast: CFTimeInterval = currentTime - lastUpdate;
            lastUpdate = currentTime;
            
            if (timeSinceLast > 1) {
                timeSinceLast = 1.0 / 60.0;
                lastUpdate = currentTime;
            }
            
            touchLength += timeSinceLast;
            
            if (touchLength > 0.3 && !addedItem && isItem && (itemBag != nil) && itemBag?.getItemObject(selectedNodeName) != nil) {
                addItem(itemBag!.getItemObject(selectedNodeName)!, tapPosition: tapLocation);
                closeBag();
            }
        }
    }
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setUpScene () {
        /* Set physicsWorld */
        physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        view?.showsPhysics = true;
        
        var bg: SKSpriteNode = SKSpriteNode(imageNamed: "background_bluepolka");
        bg.zPosition = -2;
        bg.size = CGSizeMake(self.size.width, getRatioHeight(bg.size.width, height: bg.size.height));
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
    
    func addItem (item: itemObject, tapPosition: CGPoint) {
        newItem = SKSpriteNode(imageNamed: item.itemImageName);
        
        newItem?.size = CGSizeMake(newItem!.size.width / 1.5, newItem!.size.height / 1.5);
        newItem?.position = tapPosition;
        newItem?.physicsBody = SKPhysicsBody(circleOfRadius: newItem!.size.width / 2);
        newItem?.physicsBody?.allowsRotation = true;
        newItem?.physicsBody?.dynamic = false;
        newItem?.physicsBody?.usesPreciseCollisionDetection = true;

        println("Position: \(tapPosition)");
        addedItem = true;
        self.addChild(newItem!);
    }
    
    func closeBag () {
        if (itemBag != nil) {
            itemBag?.removeFromParent();
            itemBag = nil;
        }
    }
}
