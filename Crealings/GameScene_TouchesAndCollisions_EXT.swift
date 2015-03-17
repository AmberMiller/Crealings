//
//  GameScene_TouchesAndCollisions_EXT.swift
//  Crealings
//
//  Created by Amber Miller on 3/17/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

extension GameScene {
    
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
            
            println("Node Location: \(node.position)");
            
            if (node.name != nil) {
                println("Node Name: \(node.name)");
                /* If node.name is in nameArray, close the bag and continue based on name,
                else do item shelf functions */
                let nameArray: [String] = ["crealing", "menu", "shop", "fight", "coin", "gem", "exp", "help", "happiness", "energy", "hunger", "thirst", "fun", "hygiene"];
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
                        if (gameHUD != nil && crealing!.feedPet(UsableItem.ItemType.FOOD_APPLE)) {
                            gameHUD!.feed();
                        }
                        checkMood();
                    case "thirst":
                        println("Tap Thirst");
                        if (gameHUD != nil && crealing!.hydratePet(UsableItem.ItemType.DRINK_JUICE)) {
                            gameHUD!.hydrate();
                        }
                        checkMood();
                    case "fun":
                        println("Tap Fun");
                        if (gameHUD != nil && crealing!.playWith(UsableItem.ItemType.TOY_BALL)) {
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
                        if (itemBag != nil) { //If item shelf if open, close it
                            itemBag?.removeFromParent();
                            itemBag = nil;
                            break;
                        } else { //If item shelf is not open, create it
                            itemBag = ItemBag();
                            itemBag?.setup(self)
                            self.addChild(itemBag!);
                            break;
                        }
                    } else {
                        isItem = true; //If not the bag, then node must be an item
                        selectedNodeName = node.name!; //Save node.name for long press function
                    }
                }
            }
        }
    }
    
    override func touchesMoved (touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            /* Move usable item wherever user is touching */
            if (usableItem != nil) {
                usableItem?.position = location;
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("Touch Length: \(touchLength)");
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            touching = false;
            
            /* When user lets go, allow item to fall */
            if (usableItem != nil) {
                usableItem?.physicsBody?.affectedByGravity = true;
            }
        }
    }
    
    /***********************************************************
        Collisions
    ************************************************************/
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("Did Begin Contact");
    }
}
