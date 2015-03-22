//
//  GameData.swift
//  Crealings
//
//  Created by Amber Miller on 3/9/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation

class GameData {
    
    class var sharedInstance: GameData {
        
        struct gameData {
            
            static let instance: GameData = GameData()
        }
        
        return gameData.instance
    }
    
    let fileManager = NSFileManager.defaultManager();
    let directory: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String];
    var plistPath = String();
    var gameData = NSMutableDictionary();
    
    var statusDict: Dictionary <String, AnyObject> = [:];
    
    var happiness: Int = Int();
    var energy: Int = Int();
    var hunger: Int = Int();
    var thirst: Int = Int();
    var fun: Int = Int();
    var hygiene: Int = Int();
    
    var items: Dictionary <String, AnyObject> = [:];
    var foodItems: [Dictionary <String, AnyObject>] = [];
    var drinkItems: [Dictionary <String, AnyObject>] = [];
    var toyItems: [Dictionary <String, AnyObject>] = [];
    
    func loadData () -> Bool {
        if directory != nil {
            
            let directories: [String] = directory!;
            let docPath = directories[0];
            
            let plistFile = "gameData.plist";
            plistPath = docPath.stringByAppendingPathComponent(plistFile);
            
//            resetData();

            let fileExists: Bool = fileManager.fileExistsAtPath(plistPath);
            
            /* If a file does not exist at the provided path, create a copy at the path  */
            if !fileExists {
                let sourcePath = NSBundle.mainBundle().pathForResource("gameData", ofType: "plist")
                fileManager.copyItemAtPath(sourcePath!, toPath: plistPath, error: nil);
            }
            
            /* Set data from plist */
            gameData = NSMutableDictionary(contentsOfFile: plistPath)!;
//            println("\n\nLOADING DATA\n\n\(gameData)");
            
            statusDict = gameData["Status"] as Dictionary <String, AnyObject>;
            happiness = statusDict["happiness"] as Int;
            energy = statusDict["energy"] as Int;
            hunger = statusDict["hunger"] as Int;
            thirst = statusDict["thirst"] as Int;
            fun = statusDict["fun"] as Int;
            hygiene = statusDict["hygiene"] as Int;
            
            println("Status: \(statusDict)");
            let status: Status = Status.sharedInstance;
            status.setDataFromPlist(happiness, _energy: energy, _hunger: hunger, _thirst: thirst, _fun: fun, _hygiene: hygiene);
            
            items = gameData["Items"] as Dictionary <String, AnyObject>;
            foodItems = items["Food"] as [Dictionary <String, AnyObject>];
            drinkItems = items["Drinks"] as [Dictionary <String, AnyObject>];
            toyItems = items["Toys"] as [Dictionary <String, AnyObject>];
            
            return true;
        }
        return false;
    }
    
    /***********************************************************
        Get Data
    ************************************************************/
    
    func getFoodItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Food Items Array: \(foodItems)");
        return foodItems;
    }
    
    func getDrinkItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Drink Items Array: \(drinkItems)");
        return drinkItems;
    }
    
    func getToyItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Toy Items Array: \(toyItems)");
        return toyItems;
    }
    
    /***********************************************************
        Writing Data
    ************************************************************/
    
     /* Write status data to plist */
    func writeStatus (value: Int, key: String)
    {
        statusDict.updateValue(value, forKey: key);
        gameData.setValue(statusDict, forKey: "Status");
        gameData.writeToFile(plistPath, atomically: true);
    }
    
    /* Write item data to plist */
    func writeItems (value: [Dictionary <String, AnyObject>], key: String) {
        items.updateValue(value, forKey: key);
        gameData.setValue(items, forKey: "Items");
        gameData.writeToFile(plistPath, atomically: true);
        
        println("Write Items Value: \(value), For Key: \(key)");
    }
    
    
    func setItemData (newItem: Dictionary <String, AnyObject>) {
        
        for item in foodItems {
            if (item["name"] as String == newItem["name"] as String) {
                let index: Int = item["id"] as Int;
                foodItems[index] = newItem;
                break;
            }
        }
        
        for item in drinkItems {
            if (item["name"] as String == newItem["name"] as String) {
                let index: Int = item["id"] as Int;
                drinkItems[index] = newItem;
                break;
            }
        }
        
        for item in toyItems {
            if (item["name"] as String == newItem["name"] as String) {
                let index: Int = item["id"] as Int;
                toyItems[index] = newItem;
                break;
            }
        }
        
        writeItems(foodItems, key: "Food");
        writeItems(drinkItems, key: "Drinks");
        writeItems(toyItems, key: "Toys");
    }

    
    /* Remove plist copy at filePath, completely resets all data */
    func resetData ()
    {
        fileManager.removeItemAtPath(plistPath, error: nil);
    }
}