//
//  GameData.swift
//  Crealings
//
//  Created by Amber Miller on 3/9/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation

class GameData {
    
    let fileManager = NSFileManager.defaultManager();
    let directory: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.AllDomainsMask, true) as? [String];
    var plistPath = String();
    var gameData = NSMutableDictionary();
    
//    var status: NSDictionary = [:];
//    var happiness: Int? = nil;
//    var energy: Int? = nil;
//    var hunger: Int? = nil;
//    var thirst: Int? = nil;
//    var fun: Int? = nil;
//    var hygiene: Int? = nil;
    
    var items = [:];
    var foodItems: [Dictionary <String, AnyObject>] = [];
    var drinkItems: [Dictionary <String, AnyObject>] = [];
    var toyItems: [Dictionary <String, AnyObject>] = [];
    
    func loadData ()
    {
        if directory != nil {
            
            let directories: [String] = directory!;
            let docPath = directories[0];
            
            let plistFile = "gameData.plist";
            plistPath = docPath.stringByAppendingPathComponent(plistFile);
            
            resetData();

            let fileExists: Bool = fileManager.fileExistsAtPath(plistPath);
            
            /* If a file does not exist at the provided path, create a copy at the path  */
            if !fileExists {
                let sourcePath = NSBundle.mainBundle().pathForResource("gameData", ofType: "plist")
                fileManager.copyItemAtPath(sourcePath!, toPath: plistPath, error: nil);
            }
            
            /* Set data from plist */
            gameData = NSMutableDictionary(contentsOfFile: plistPath)!;
            println("/n/nLOADING DATA\n\n\(gameData)");
            
//            status = gameData["Status"] as NSDictionary;
//            happiness = status["happiness"] as? Int;
//            energy = status["energy"] as? Int;
//            hunger = status["hunger"] as? Int;
//            thirst = status["thirst"] as? Int;
//            fun = status["fun"] as? Int;
//            hygiene = status["hygiene"] as? Int;
            
            items = gameData["Items"] as Dictionary <String, AnyObject>;
            foodItems = items["Food"] as [Dictionary <String, AnyObject>];
            drinkItems = items["Drinks"] as [Dictionary <String, AnyObject>];
            toyItems = items["Toys"] as [Dictionary <String, AnyObject>];
        }
    }
    
    func getFoodItemsArray () -> [Dictionary <String, AnyObject>] {
        return foodItems;
    }
    
    func getDrinkItemsArray () -> [Dictionary <String, AnyObject>] {
        return drinkItems;
    }
    
    func getToyItemsArray () -> [Dictionary <String, AnyObject>] {
        return toyItems;
    }
    
    /* Write data to plist */
//    func writeStatus (value: Int, key: String)
//    {
//        status.setValue(value, forKey: key);
//        gameData.writeToFile(plistPath, atomically: true);
//    }
    
//    /***********************************************************
//        Set
//    ************************************************************/
//    
//    func setHappiness (change: Int) -> Int {
//        happiness = getHappiness();
//        happiness! += change;
//        if (happiness > 100) {
//            happiness = 100;
//        } else if (happiness < 0) {
//            happiness = 0;
//        }
//        writeStatus(happiness!, key: "happiness");
//        return happiness!;
//    }
//    
//    func setEnergy (change: Int) -> Int {
//        energy = getEnergy();
//        energy! += change;
//        if (energy > 100) {
//            energy = 100;
//        } else if (energy < 0) {
//            energy = 0;
//        }
//        return energy!;
//    }
//    
//    func setHunger (change: Int) -> Int {
//        hunger = getHunger();
//        hunger! += change;
//        if (hunger > 100) {
//            hunger = 100;
//        } else if (hunger < 0) {
//            hunger = 0;
//        }
//        return hunger!;
//    }
//    
//    func setThirst (change: Int) -> Int {
//        thirst = getThirst();
//        thirst! += change
//        if (thirst > 100) {
//            thirst = 100;
//        } else if (thirst < 0) {
//            thirst = 0;
//        }
//        return thirst!;
//    }
//    
//    func setFun (change: Int) -> Int {
//        fun = getFun();
//        fun! += change;
//        if (fun > 100) {
//            fun = 100;
//        } else if (fun < 0) {
//            fun = 0;
//        }
//        return fun!;
//    }
//    
//    func setHygiene (change: Int) -> Int {
//        hygiene = getHygiene();
//        hygiene! += change;
//        if (hygiene > 100) {
//            hygiene = 100;
//        } else if (hygiene < 0) {
//            hygiene = 0;
//        }
//        return hygiene!;
//    }
//    
//    
//    /***********************************************************
//        Get
//    ************************************************************/
//    
//    func getMoodTotal () -> Int {
//        let moodTotal = (getHappiness() + getEnergy() + getHunger() + getThirst() + getFun() + getHygiene()) / 6;
//        return moodTotal;
//    }
//    
//    func getHappiness () -> Int {
//        if (happiness == nil) {
//            loadData()
//        } else {
//            happiness = status["happiness"] as? Int;
//        }
//        println("Happiness: \(happiness!)");
//        return happiness!;
//    }
//    
//    func getEnergy () -> Int {
//        if (energy == nil) {
//            loadData()
//        } else {
//            energy = status["energy"] as? Int;
//        }
//        println("Energy: \(energy!)");
//        return energy!;
//    }
//    
//    func getHunger () -> Int {
//        if (hunger == nil) {
//            loadData()
//        } else {
//            hunger = status["hunger"] as? Int;
//        }
//        println("Hunger: \(hunger!)");
//        return hunger!;
//    }
//    
//    func getThirst () -> Int {
//        if (thirst == nil) {
//            loadData()
//        } else {
//            thirst = status["thirst"] as? Int;
//        }
//        println("Thirst: \(thirst!)");
//        return thirst!;
//    }
//    
//    func getFun () -> Int {
//        if (fun == nil) {
//            loadData()
//        } else {
//            fun = status["fun"] as? Int;
//        }
//        println("Fun: \(fun!)");
//        return fun!;
//    }
//    
//    func getHygiene () -> Int {
//        if (hygiene == nil) {
//            loadData()
//        } else {
//            hygiene = status["hygiene"] as? Int;
//        }
//        println("Hygiene: \(hygiene!)");
//        return hygiene!;
//    }
    
    /* Remove plist copy at filePath, completely resets all data */
    func resetData ()
    {
        fileManager.removeItemAtPath(plistPath, error: nil);
    }
}