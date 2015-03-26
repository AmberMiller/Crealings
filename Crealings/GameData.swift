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
    
    private let fileManager = NSFileManager.defaultManager();
    private let directory: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String];
    private var plistPath = String();
    private var gameData = NSMutableDictionary();
    
    private var userCoins: Int = Int();
    private var userGems: Int = Int();
    private var userBackground: String = String();
    
    private var statusDict: Dictionary <String, AnyObject> = [:];
    
    private var happiness: Int = Int();
    private var energy: Int = Int();
    private var hunger: Int = Int();
    private var thirst: Int = Int();
    private var fun: Int = Int();
    private var hygiene: Int = Int();
    
    private var items: Dictionary <String, AnyObject> = [:];
    private var foodAndDrinkItems: [Dictionary <String, AnyObject>] = [];
    private var careItems: [Dictionary <String, AnyObject>] = [];
    private var decorationItems: [Dictionary <String, AnyObject>] = [];
    
    private var statsArray: [Dictionary <String, AnyObject>] = [];
    
    func loadData () -> Bool {
        if directory != nil {
            
            let directories: [String] = directory!;
            let docPath = directories[0];
            println("Doc Path: \(docPath)");
            
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
            println("\n\nLOADING DATA\n\n\(gameData)");
            
            userCoins = gameData["userCoins"] as Int;
            userGems = gameData["userGems"] as Int;
            userBackground = gameData["userBackground"] as String;
            
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
            foodAndDrinkItems = items["FoodAndDrinks"] as [Dictionary <String, AnyObject>];
            careItems = items["Care"] as [Dictionary <String, AnyObject>];
            decorationItems = items["Decorations"] as [Dictionary <String, AnyObject>];
            
            statsArray = gameData["Stats"] as [Dictionary <String, AnyObject>];
            
            return true;
        }
        return false;
    }
    
    /***********************************************************
        Get Data
    ************************************************************/
    
    func getUserCoins () -> Int {
        println("Get User Coins: \(userCoins)");
        return userCoins;
    }
    
    func getFoodAndDrinkItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Food And Drink Items Array: \(foodAndDrinkItems)");
        return foodAndDrinkItems;
    }
    
    func getCareItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Care Items Array: \(careItems)");
        return careItems;
    }
    
    func getDecorationItemsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Decoration Items Array: \(decorationItems)");
        return decorationItems;
    }
    
    func getStatsArray () -> [Dictionary <String, AnyObject>] {
        println("Get Stats Array: \(statsArray)");
        return statsArray;
    }
    
    func getBackground () -> String {
        println("Get Background: \(userBackground)");
        return userBackground;
    }
    
    /***********************************************************
        Writing Data
    ************************************************************/
    
    /* Write Data to plist */
    func writeData (value: AnyObject, key: String) {
        gameData.setValue(value, forKey: key);
        gameData.writeToFile(plistPath, atomically: true);
    }
    
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
    
    func writeStats (value: [Dictionary <String, AnyObject>], key: String) {
        gameData.setValue(value, forKey: key);
        gameData.writeToFile(plistPath, atomically: true);
    }
    
    
    func setItemData (newItem: Dictionary <String, AnyObject>) {
        loadData();
        var found: Bool = Bool();
        
        for item in foodAndDrinkItems {
            if (item["name"] as String == newItem["name"] as String) {
                let index: Int = item["id"] as Int;
                foodAndDrinkItems[index] = newItem;
                found = true;
                break;
            }
        }

        if (!found) {
            for item in careItems {
                if (item["name"] as String == newItem["name"] as String) {
                    let index: Int = item["id"] as Int;
                    careItems[index] = newItem;
                    found = true;
                    break;
                }
            }
        }

        if (!found) {
            for item in decorationItems {
                if (item["name"] as String == newItem["name"] as String) {
                    let index: Int = item["id"] as Int;
                    decorationItems[index] = newItem;
                    found = true;
                    break;
                }
            }
        }

        
        if (found) {
            writeItems(foodAndDrinkItems, key: "FoodAndDrinks");
            writeItems(careItems, key: "Care");
            writeItems(decorationItems, key: "Decorations");
        }
    }

    
    /* Remove plist copy at filePath, completely resets all data */
    func resetData ()
    {
        fileManager.removeItemAtPath(plistPath, error: nil);
    }
}