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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
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
                let nameArray: [String] = ["crealing", "menu", "shop", "fight", "coin", "gem", "exp", "help", "happiness", "energy", "hunger", "thirst", "fun", "hygiene", "toStart", "exit", "foodDrinksTab", "careTab", "accessoriesTab", "decorationsTab", "premiumTab", "next", "previous", "exitHelp"];
                let found = find(nameArray, node.name!) != nil;
                
                if (found) {
                    if (node.name != "exit") {
                        closeBag();
                    }
                    
                    isItem = false;
                    
                    switch node.name! {
                    case "crealing":
                        if (crealing!.isAlive) { //If alive, interact with
                            if (crealing!.tapPet()) {
                                gameHUD!.interactWith();
                            }
                        } else { //If dead, show alert
                            alertBox = AlertBox();
                            if (alertBox!.setup(self, from: "game_over", item: nil)) {
                                self.addChild(alertBox!);
                            }
                        }
                    case "menu":
                        println("Tap Menu");
                        gameDelegate?.MenuButtonClicked();
                    case "shop":
                        println("Tap Shop");
                        shopButtonClicked();
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
                        helpButtonClicked();
                    case "happiness", "energy", "hunger", "thirst", "fun", "hygiene":
                        println("Status Bar Tapped");
                    case "toStart":
                        self.removeAllActions();
                        self.removeAllChildren();
                        self.userData = nil;
                        gameDelegate?.clearGame();
                    case "exit":
                        if (alertBox != nil) { //If alert box is open, close it
                            alertBox?.removeFromParent();
                            alertBox = nil;
                            break;
                        }
                    case "foodDrinksTab", "careTab", "accessoriesTab", "decorationsTab", "premiumTab":
                        if (shopHUD != nil) {
                            shopHUD!.tapTab(node.name!);
                        }
                    case "next":
                        helpScreen?.tapNext();
                    case "previous":
                        helpScreen?.tapPrevious();
                    case "exitHelp":
                        helpButtonClicked();
                    default:
                        break;
                    }
                } else {
                    if (itemShopOpen) {
                        shopHUD?.buyItem(node.name!);
                    } else {
                        println("Item Shelf Tapped");
                        if (node.name == "bag") {
                            println("Tap Bag");
                            isItem = false;
                            if (itemBag != nil) { //If item shelf is open, close it
                                itemBag?.removeFromParent();
                                itemBag = nil;
                                break;
                            } else { //If item shelf is not open, create it
                                itemBag = ItemBag();
                                itemBag?.zPosition = 2;
                                itemBag?.setup(self, gameView: gameView)
                                self.addChild(itemBag!);
                                break;
                            }
                        } else {
                            isItem = true; //If not the bag, then node must be an item
                            selectedNodeName = node.name!; //Save node.name for long press function
                            usableItemDict = itemBag!.getItemDict(selectedNodeName)!;
                            if (!(usableItemDict!["isConsumable"] as! Bool)) {
                                let imageName = usableItemDict!["image"] as! String;
                                if (bg != nil) {
                                    gameData.writeData(imageName, key: "userBackground");
                                    bg!.texture = SKTexture(imageNamed: imageName);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            /* Move usable item wherever user is touching */
            if (usableItem != nil) {
                usableItem?.position = location;
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Touch Length: \(touchLength)");
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            touching = false;
            
            if (touchLength < 0.2 && isItem) {
                alertBox = AlertBox();
                alertBox?.setup(self, from: "item", item: usableItemDict);
                self.addChild(alertBox!);
            }
            
            /* When user lets go, allow item to fall */
            if (usableItem != nil) {
                usableItem?.physicsBody?.affectedByGravity = true;
            }
            
            /* If the item is over the crealing, give item when user lets go */
            if (itemHovering) {
                giveItemToPet();
            }
        }
    }
    
    /***********************************************************
        Collisions
    ************************************************************/
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("Did Begin Contact");
        
        /* Set contact bodies to variables */
        var firstBody: SKPhysicsBody, secondBody: SKPhysicsBody = SKPhysicsBody();
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        /* If item touches the edge, remove item */
        if firstBody.categoryBitMask == CollisionType.ITEM.rawValue && secondBody.categoryBitMask == CollisionType.FLOOR.rawValue {
            if (!touching) {
                //TODO: Add poof animation on removal
                usableItem?.removeFromParent();
                usableItem = nil;
            }
        }
        
        /* If item is dropped on crealing, interact with crealing and remove item */
        if firstBody.categoryBitMask == CollisionType.CREALING.rawValue && secondBody.categoryBitMask == CollisionType.ITEM.rawValue {
            
            itemHovering = true; //Item is over crealing
            
            /* If the user drops the item above the crealing, give item */
            if (!touching) {
                giveItemToPet();
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        println("Did End Contact");
        
        /* Set contact bodies to variables */
        var firstBody: SKPhysicsBody, secondBody: SKPhysicsBody = SKPhysicsBody();
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        /* If item stops touching crealing */
        if firstBody.categoryBitMask == CollisionType.CREALING.rawValue && secondBody.categoryBitMask == CollisionType.ITEM.rawValue {
            itemHovering = false; //Item is not over crealing
        }
    }
    
    /* Pull item data, set status changes, refresh mood, and remove item from scene */
    func giveItemToPet () {
        
        if (usableItemDict != nil && crealing!.giveItem(usableItemDict!["happinessChange"] as! Int,
            energy: usableItemDict!["energyChange"] as! Int,
            hunger: usableItemDict!["hungerChange"] as! Int,
            thirst: usableItemDict!["thirstChange"] as! Int,
            fun: usableItemDict!["funChange"] as! Int,
            hygiene: usableItemDict!["hygieneChange"] as! Int))
        {
            let itemName: String = usableItemDict!["name"] as! String;
            println("Item Given to Pet: \(itemName)");
            
            gameHUD!.interactWith();
            checkMood();
            
            var numOwned: Int = usableItemDict!["numOwned"] as! Int;
            numOwned -= 1;
            usableItemDict!.updateValue(numOwned, forKey: "numOwned");
            gameData.setItemData(usableItemDict!);             
            usableItem?.removeFromParent();
            usableItem = nil;
            usableItemDict = nil;
            itemHovering = false;
        }
    }
}
