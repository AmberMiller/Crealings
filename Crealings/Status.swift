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
    
    var happiness: Int = 100;
    var energy: Int = 80;
    var hunger: Int = 60;
    var thirst: Int = 50;
    var fun: Int = 30;
    var hygiene: Int = 10;
    
    /***********************************************************
        Set
    ************************************************************/
    
    func setHappiness (change: Int) -> Int {
        happiness = getHappiness();
        happiness += change;
        if (happiness > 100) {
            happiness = 100;
        } else if (happiness < 0) {
            happiness = 0;
        }
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
        return hygiene;
    }
    
    
    /***********************************************************
        Get
    ************************************************************/
    
    func getMoodTotal () -> Int {
        let moodTotal = (getHappiness() + getEnergy() + getHunger() + getThirst() + getFun() + getHygiene()) / 6;
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