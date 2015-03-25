//
//  ShopHUD.swift
//  Crealings
//
//  Created by Amber Miller on 3/23/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class ShopHUD: SKSpriteNode {
    
    var foodAndDrinksArray: [Dictionary <String, AnyObject>] = [];
    var careArray: [Dictionary <String, AnyObject>] = [];
    var decorationsArray: [Dictionary <String, AnyObject>] = [];
    
    var currentArray: [Dictionary <String, AnyObject>] = [];
    var currentTab: String = String();
    
    var gameData: GameData = GameData.sharedInstance;
    
    var gameView: GameScene? = nil;
    
    let itemsSprite: JADSKScrollingNode = JADSKScrollingNode();
    let tabsSprite: SKNode = SKNode();
    var numOwned: SKLabelNode? = nil;
    
    var foodDrinksTab: SKSpriteNode = SKSpriteNode();
    var careTab: SKSpriteNode = SKSpriteNode();
    var accessoriesTab: SKSpriteNode = SKSpriteNode();
    var decorationsTab: SKSpriteNode = SKSpriteNode();
    var premiumTab: SKSpriteNode = SKSpriteNode();
    
    var numLabelArray: [SKLabelNode] = [];
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setup (view: GameScene, skView: SKView) -> Bool {
        gameView = view;
        
        self.anchorPoint = CGPointMake(0.5, 0.0);
        self.color = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
        self.size = CGSizeMake(gameView!.size.width, gameView!.size.height / 1.4);
        self.position = CGPointMake(gameView!.size.width / 2, -gameView!.size.height);
        self.zPosition = 2;
        
        itemsSprite.enableScrollingOnView(skView);
        tabsSprite.position = CGPointMake(0.0, 0.0);
        
        foodDrinksTab = SKSpriteNode(imageNamed: "food_drinks_tab_selected");
        foodDrinksTab.anchorPoint = CGPointMake(0.5, 0.0);
        foodDrinksTab.position = CGPointMake(-self.size.width / 2.5, 0.0);
        let height: CGFloat = self.size.height * 0.2;
        let width = getRatio(foodDrinksTab.size.width, height: foodDrinksTab.size.height, newHeight: height, newWidth: nil);
        foodDrinksTab.size = CGSizeMake(width, height);
        foodDrinksTab.name = "foodDrinksTab";
        
        careTab = SKSpriteNode(imageNamed: "care_tab");
        careTab.anchorPoint = CGPointMake(0.5, 0.0);
        careTab.position = CGPointMake(-self.size.width / 5, 0.0);
        careTab.size = CGSizeMake(width, height);
        careTab.name = "careTab";
        
        accessoriesTab = SKSpriteNode(imageNamed: "food_drinks_tab");
        accessoriesTab.anchorPoint = CGPointMake(0.5, 0.0);
        accessoriesTab.position = CGPointMake(0.0, 0.0);
        accessoriesTab.size = CGSizeMake(width, height);
        accessoriesTab.name = "accessoriesTab";
        
        decorationsTab = SKSpriteNode(imageNamed: "care_tab");
        decorationsTab.anchorPoint = CGPointMake(0.5, 0.0);
        decorationsTab.position = CGPointMake(self.size.width / 5, 0.0);
        decorationsTab.size = CGSizeMake(width, height);
        decorationsTab.name = "decorationsTab";
        
        premiumTab = SKSpriteNode(imageNamed: "premium_tab");
        premiumTab.anchorPoint = CGPointMake(0.5, 0.0);
        premiumTab.position = CGPointMake(self.size.width / 2.5, 0.0);
        premiumTab.size = CGSizeMake(width, height);
        premiumTab.name = "premiumTab";
        
        tabsSprite.addChild(foodDrinksTab);
        tabsSprite.addChild(careTab);
        tabsSprite.addChild(accessoriesTab);
        tabsSprite.addChild(decorationsTab);
        tabsSprite.addChild(premiumTab);
        
        self.addChild(itemsSprite);
        self.addChild(tabsSprite);
        
        if (loadData()) {
            currentArray = foodAndDrinksArray;
            currentTab = "foodDrinksTab";
            addItems();
        }
        
        return true;
    }
    
    func loadData () -> Bool {
        if (gameData.loadData()) {
            foodAndDrinksArray = gameData.getFoodAndDrinkItemsArray();
            careArray = gameData.getCareItemsArray();
            decorationsArray = gameData.getDecorationItemsArray();
            println("Decorations Array: \(decorationsArray)");
        }
        
        return true;
    }
    
    /* Return new dimension with image ratio */
    func getRatio (width: CGFloat, height: CGFloat, newHeight: CGFloat?, newWidth: CGFloat?) -> CGFloat {
        var ratio: CGFloat;
        var newDimension: CGFloat;
        
        if (height > width) {
            ratio = height / width;
            
            if (newHeight == nil) {
                return newWidth! * ratio;
            } else {
                return newHeight! / ratio;
            }
        } else {
            ratio = width / height;
            
            if (newWidth == nil) {
                return newHeight! * ratio;
            } else {
                return newWidth! / ratio;
            }
        }
    }
    
    /***********************************************************
        Animations
    ************************************************************/
    
    func animateIn () {
        let moveAction: SKAction = SKAction.moveTo(CGPointMake(gameView!.size.width / 2, 0.0), duration: 0.3);
        self.runAction(moveAction);
    }
    
    func animateOut () -> Bool {
        gameData.writeItems(foodAndDrinksArray, key: "FoodAndDrinks");
        gameData.writeItems(careArray, key: "Care");
        gameData.writeItems(decorationsArray, key: "Decorations");

        
        let moveAction: SKAction = SKAction.moveTo(CGPointMake(gameView!.size.width / 2, -gameView!.size.height), duration: 0.3);
        let sequence: SKAction = SKAction.sequence([
            moveAction,
            SKAction.removeFromParent()
        ]);
        self.runAction(moveAction);
        
        return true;
    }

    /***********************************************************
        Add Items
    ************************************************************/
    
    func addItems () {
        
        itemsSprite.removeAllChildren();
        numLabelArray.removeAll();
        
        for (var i = 0; i < currentArray.count; i++) {
            let currentItem: Dictionary <String, AnyObject> = currentArray[i];
            
            let itemBox: SKSpriteNode = SKSpriteNode(imageNamed: "itemBox");
            
            let ratio: CGFloat = itemBox.size.width / itemBox.size.height;
            let height: CGFloat = self.size.height / 1.6;
            let ratioWidth: CGFloat = height / ratio;
            let position: CGFloat = (-self.size.width / 2.7);
            itemBox.size = CGSizeMake(height, ratioWidth);
            itemBox.position = CGPointMake(position + ((ratioWidth / 1.3) * CGFloat(i)), self.size.height / 1.55);
            itemBox.zPosition = 3;
            
            let name: SKLabelNode = SKLabelNode(text: currentItem["name"] as String);
            name.fontName = "MarkerFelt-Thin";
            name.fontColor = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
            name.position = CGPointMake(0.0, itemBox.size.height / 2.8);
            
            let image: SKSpriteNode = SKSpriteNode(imageNamed: currentItem["imageName"] as String);
            image.position = CGPointMake(0.0, itemBox.size.height / 8.5);
            let imageSize = itemBox.size.width / 1.8;
            image.size = CGSizeMake(imageSize, imageSize);
            
            let description: DSMultilineLabelNode = DSMultilineLabelNode();
            description.text = currentItem["description"] as String;
            description.fontName = "MarkerFelt-Thin";
            description.fontColor = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
            description.position = CGPointMake(0.0, -itemBox.size.height / 6);
            description.paragraphWidth = itemBox.size.width - 20.0;
            
            let cost: SKLabelNode = SKLabelNode(text: toString(currentItem["cost"]!));
            cost.fontName = "MarkerFelt-Thin";
            cost.fontColor = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
            cost.position = CGPointMake(-itemBox.size.width / 5.8, -itemBox.size.height / 3);
            
            let numOwned: SKLabelNode = SKLabelNode(text: toString(currentItem["numOwned"]!));
            numOwned.fontName = "MarkerFelt-Thin";
            numOwned.fontColor = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
            numOwned.position = CGPointMake(itemBox.size.width / 2.5, -itemBox.size.height / 3);
            numOwned.name = toString(i);
            numLabelArray.append(numOwned);
            
            let owned: SKLabelNode = SKLabelNode(text: "Owned");
            owned.fontName = "MarkerFelt-Thin";
            owned.fontColor = UIColor(red: 0.565, green: 0.4, blue: 0.776, alpha: 1); /*#9066c6*/
            owned.position = CGPointMake(0.0, -itemBox.size.height / 3);
            
            let buyButton: SKSpriteNode = SKSpriteNode(imageNamed: "buy_button");
            buyButton.position = CGPointMake(0.0, -itemBox.size.height / 2.3);
            buyButton.name = toString(i);
            
            if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                name.fontSize = 22;
                description.fontSize = 15;
                cost.fontSize = 22;
            } else {
                name.fontSize = 32;
                description.fontSize = 25;
                cost.fontSize = 32;
            }
            
            itemBox.addChild(name);
            itemBox.addChild(image);
            itemBox.addChild(description);
            
            if ((currentTab == "accessoriesTab" || currentTab == "decorationsTab") && currentItem["numOwned"] as Int > 0) {
                itemBox.addChild(owned);
            } else {
                itemBox.addChild(cost);
                itemBox.addChild(numOwned);
                itemBox.addChild(buyButton);
            }
            
            itemsSprite.addChild(itemBox);
        }
    }
    
    /***********************************************************
            Actions
    ************************************************************/
    
    /* When tab is tapped, change image and displayed items array */
    func tapTab (nodeName: String) {
        switch nodeName {
            case "foodDrinksTab":
                currentArray = foodAndDrinksArray;
                if (currentTab != "foodDrinksTab") {
                    currentTab = "foodDrinksTab";
                    foodDrinksTab.texture = SKTexture(imageNamed: "food_drinks_tab_selected");
                    careTab.texture = SKTexture(imageNamed: "care_tab");
                    premiumTab.texture = SKTexture(imageNamed: "premium_tab");
                    addItems();
                }
            case "careTab":
                currentArray = careArray;
                if (currentTab != "careTab") {
                    currentTab = "careTab";
                    foodDrinksTab.texture = SKTexture(imageNamed: "food_drinks_tab");
                    careTab.texture = SKTexture(imageNamed: "care_tab_selected");
                    premiumTab.texture = SKTexture(imageNamed: "premium_tab");
                    addItems();
                }
            case "accessoriesTab":
                currentArray = foodAndDrinksArray;
                if (currentTab != "accessoriesTab") {
                    currentTab = "accessoriesTab";
                    foodDrinksTab.texture = SKTexture(imageNamed: "food_drinks_tab");
                    careTab.texture = SKTexture(imageNamed: "care_tab");
                    premiumTab.texture = SKTexture(imageNamed: "premium_tab");
                    addItems();
                }
            case "decorationsTab":
                currentArray = decorationsArray;
                if (currentTab != "decorationsTab") {
                    currentTab = "decorationsTab";
                    foodDrinksTab.texture = SKTexture(imageNamed: "food_drinks_tab");
                    careTab.texture = SKTexture(imageNamed: "care_tab");
                    premiumTab.texture = SKTexture(imageNamed: "premium_tab");
                    addItems();
                }

            case "premiumTab":
                currentArray = foodAndDrinksArray;
                if (currentTab != "premiumTab") {
                    currentTab = "premiumTab";
                    foodDrinksTab.texture = SKTexture(imageNamed: "food_drinks_tab");
                    careTab.texture = SKTexture(imageNamed: "care_tab");
                    premiumTab.texture = SKTexture(imageNamed: "premium_tab_selected");
                    addItems();
                }
            default:
                println("ERROR: No tab tapped");
        }
        
    }
    
    /* Increase numOwned for item and set in array */
    func buyItem (nodeName: String) {
        let id = nodeName.toInt();
        var item = currentArray[id!];
        
        //TODO Check user coins and compare to item cost
        var itemNumOwned: Int = item["numOwned"] as Int;
        itemNumOwned += 1;
        
        item.updateValue(itemNumOwned, forKey: "numOwned");
        
        for label in numLabelArray {
            if (id == label.name!.toInt()) {
                label.text = toString(itemNumOwned);
            }
        }
        
        //TODO Subtract coins for cost

        switch currentTab {
            case "foodDrinksTab":
                foodAndDrinksArray[id!] = item;
                currentArray = foodAndDrinksArray;
            case "careTab":
                careArray[id!] = item;
                currentArray = careArray;
            case "decorationsTab":
                decorationsArray[id!] = item;
                currentArray = decorationsArray;
                addItems();
            default:
                println("No Tab");
        }
    }
}
