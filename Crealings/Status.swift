//
//  Status.swift
//  Crealings
//
//  Created by Amber Miller on 3/9/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation

final class Status {
    
    class var sharedInstance: Status {
        
        struct statusData {
            
            static let instance: Status = Status()
        }
        
        return statusData.instance
    }
    
    var gameData: GameData = GameData.sharedInstance;
    
    var happiness: Int = Int();
    var energy: Int = Int();
    var hunger: Int = Int();
    var thirst: Int = Int();
    var fun: Int = Int();
    var hygiene: Int = Int();
    
    /***********************************************************
        Set
    ************************************************************/
    
    func setDataFromPlist (_happiness: Int, _energy: Int, _hunger: Int, _thirst: Int, _fun: Int, _hygiene: Int) {
        happiness = _happiness;
        energy = _energy;
        hunger = _hunger;
        thirst = _thirst;
        fun = _fun;
        hygiene = _hygiene;
    }
    
    func resetData () {
        happiness = 80;
        energy = 100;
        hunger = 80;
        thirst = 80;
        fun = 80;
        hygiene = 100;
        
        gameData.writeStatus(happiness, key: "happiness");
        gameData.writeStatus(energy, key: "energy");
        gameData.writeStatus(hunger, key: "hunger");
        gameData.writeStatus(thirst, key: "thirst");
        gameData.writeStatus(fun, key: "fun");
        gameData.writeStatus(hygiene, key: "hygiene");
    }
    
    func setHappiness (change: Int) -> Int {
        happiness = getHappiness();
        happiness += change;
        if (happiness > 100) {
            happiness = 100;
        } else if (happiness < 0) {
            happiness = 0;
        }
        
        gameData.writeStatus(happiness, key: "happiness");
        return happiness;
    }
    
    func setEnergy (change: Int) -> Int {
        energy = getEnergy();
        energy += change;
        if (energy > 100) {
            energy = 100;
        } else if (energy < 0) {
            energy = 0;
        }
        
        gameData.writeStatus(energy, key: "energy");
        return energy;
    }
    
    func setHunger (change: Int) -> Int {
        hunger = getHunger();
        hunger += change;
        if (hunger > 100) {
            hunger = 100;
        } else if (hunger < 0) {
            hunger = 0;
        }
        
        gameData.writeStatus(hunger, key: "hunger");
        return hunger;
    }
    
    func setThirst (change: Int) -> Int {
        thirst = getThirst();
        thirst += change
        if (thirst > 100) {
            thirst = 100;
        } else if (thirst < 0) {
            thirst = 0;
        }
        
        gameData.writeStatus(thirst, key: "thirst");
        return thirst;
    }
    
    func setFun (change: Int) -> Int {
        fun = getFun();
        fun += change;
        if (fun > 100) {
            fun = 100;
        } else if (fun < 0) {
            fun = 0;
        }
        
        gameData.writeStatus(fun, key: "fun");
        return fun;
    }
    
    func setHygiene (change: Int) -> Int {
        hygiene = getHygiene();
        hygiene += change;
        if (hygiene > 100) {
            hygiene = 100;
        } else if (hygiene < 0) {
            hygiene = 0;
        }
        
        gameData.writeStatus(hygiene, key: "hygiene");
        return hygiene;
    }
    
    
    /***********************************************************
        Get
    ************************************************************/
    
    func getMoodTotal () -> Int {
        let moodTotal = (happiness + energy + hunger + thirst + fun + hygiene) / 6;
        return moodTotal;
    }
    
    func getHappiness () -> Int {
        println("Happiness: \(happiness)");
        return happiness;
    }
    
    func getEnergy () -> Int {
        println("Energy: \(energy)");
        return energy;
    }
    
    func getHunger () -> Int {
        println("Hunger: \(hunger)");
        return hunger;
    }
    
    func getThirst () -> Int {
        println("Thirst: \(thirst)");
        return thirst;
    }
    
    func getFun () -> Int {
        println("Fun: \(fun)");
        return fun;
    }
    
    func getHygiene () -> Int {
        println("Hygiene: \(hygiene)");
        return hygiene;
    }
    
}