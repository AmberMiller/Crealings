//
//  Crealing.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

final class Crealing : SKNode {
    
    var crealingSprite: SKSpriteNode? = nil;
    var animAtlas: SKTextureAtlas? = nil;
    var blinkAnimTextures: [SKTexture] = [];
    var blinkAnim: SKAction = SKAction();
    
    var age: Int = 0;

    var str: Int = 5;
    var dex: Int = 5;
    var con: Int = 10;
    
    var maxHealth: Int = 0;
    var currentHealth: Int = 0;
    
    var happiness: Int = 100;
    var hunger: Int = 0;
    var thirst: Int = 0;
    var fun: Int = 0;
    var energy: Int = 0;
    var hygiene: Int = 0;
    
    var idle: Bool = true;
    var isAlive: Bool = true;
    
    var moodTotal: Int = 100;
    
    var crealingImages: [String] = [];
    let pHatchlingImages = ["pVeryHappy", "pMoreHappy", "pHappy", "pNeutral", "pUnhappy", "pSad", "pVerySad", "pDying"];

    
    /***********************************************************
        Set Up
    ************************************************************/
    func setup (view: GameScene, mon: String) -> Bool {
        
        switch mon {
            case "pHatchling":
                crealingImages = pHatchlingImages;
            default:
                println("Error: No Crealing Set");
        }
        setMood(getMood())

        self.addChild(crealingSprite!);

        isAlive = true;
        return true;
    }
    
    /***********************************************************
        Crealing Mood
    ************************************************************/
    
    //Set mood based on current stats
    func getMood () -> GameScene.Mood {
        var mood: GameScene.Mood;
        let moodTotal = (happiness + hunger + thirst + fun + energy + hygiene) / 6;
        println("Mood Total: \(moodTotal)")
        switch moodTotal {
            case 90...100:
                mood = GameScene.Mood.VERY_HAPPY;
            case 79...89:
                mood = GameScene.Mood.MORE_HAPPY;
            case 65...78:
                mood = GameScene.Mood.HAPPY;
            case 50...64:
                mood = GameScene.Mood.NEUTRAL;
            case 40...49:
                mood = GameScene.Mood.UNHAPPY;
            case 26...39:
                mood = GameScene.Mood.SAD;
            case 15...25:
                mood = GameScene.Mood.VERY_SAD;
            case 1...14:
                mood = GameScene.Mood.DYING;
            case 0:
                mood = GameScene.Mood.DYING;
                isAlive = false;
            default:
                mood = GameScene.Mood.NEUTRAL;
        }
        return mood;
    }
    
    func setMood (mood: GameScene.Mood) {
        var moodName: String = "";
        //Set current atlas based on mood
        switch mood {
        case .VERY_HAPPY:
            animAtlas = SKTextureAtlas(named: crealingImages[0]);
            moodName = "vhappy";
        case .MORE_HAPPY:
            animAtlas = SKTextureAtlas(named: crealingImages[1]);
            moodName = "mhappy";
        case .HAPPY:
            animAtlas = SKTextureAtlas(named: crealingImages[2]);
            moodName = "happy";
        case .NEUTRAL:
            animAtlas = SKTextureAtlas(named: crealingImages[3]);
            moodName = "neutral";
        case .UNHAPPY:
            animAtlas = SKTextureAtlas(named: crealingImages[4]);
            moodName = "unhappy";
        case .SAD:
            animAtlas = SKTextureAtlas(named: crealingImages[5]);
            moodName = "sad";
        case .VERY_SAD:
            animAtlas = SKTextureAtlas(named: crealingImages[6]);
            moodName = "cry";
        case .DYING:
            animAtlas = SKTextureAtlas(named: crealingImages[7]);
            moodName = "dying";
        default:
            animAtlas = SKTextureAtlas(named: crealingImages[3]);
            moodName = "neutral"
        }
        
        blinkAnimTextures.removeAll();
        
        //Loop through atlas forward and back for animation sequence
        let atlasNum = animAtlas!.textureNames.count / 3;
        for (var i = 1; i < atlasNum; i++) {
            let name = moodName + "\(i)"
            println(name)
            
            blinkAnimTextures.append(self.animAtlas!.textureNamed(name)!)
        }
        for (var i = atlasNum; i > 0; i--) {
            let name = moodName + "\(i)"
            println(name)
            blinkAnimTextures.append(self.animAtlas!.textureNamed(name)!)
            
        }
        
        //Set animation
        blinkAnim = SKAction.animateWithTextures(blinkAnimTextures, timePerFrame: 0.1);
        
        if (crealingSprite == nil) {
            crealingSprite = SKSpriteNode(texture: blinkAnimTextures[0]);
        }
        if (crealingSprite!.hasActions()) {
            crealingSprite?.removeActionForKey("blinkAction")
        }
        runBlinkAnim()
    }
    
    //Run animation with wait time and loop forever
    func runBlinkAnim () {
        var loop: SKAction;
        var loopAnimTextures: [SKTexture] = [];
        
        //If sad or very sad, loop first two images before running blinkAnim
        if (getMood() == GameScene.Mood.VERY_HAPPY || getMood() == GameScene.Mood.SAD || getMood() == GameScene.Mood.VERY_SAD) {
            var moodName: String = "";
            if (getMood() == GameScene.Mood.VERY_HAPPY) {
                loopAnimTextures = [animAtlas!.textureNamed("vhappy1"), animAtlas!.textureNamed("vhappy2")];
            }
            if (getMood() == GameScene.Mood.SAD) {
                loopAnimTextures = [animAtlas!.textureNamed("sad1"), animAtlas!.textureNamed("sad2")];
            }
            if (getMood() == GameScene.Mood.VERY_SAD) {
                loopAnimTextures = [animAtlas!.textureNamed("cry1"), animAtlas!.textureNamed("cry2")];
            }
            let loopAnim = SKAction.animateWithTextures(loopAnimTextures, timePerFrame: 0.1);

            loop = SKAction.sequence([
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    loopAnim,
                    blinkAnim
                
            ]);
        } else {
            let wait = SKAction.waitForDuration(5)
            let actions = [blinkAnim, wait]
            loop = SKAction.sequence([
                blinkAnim,
                SKAction.waitForDuration(5),
            ])
        }

        crealingSprite?.runAction(SKAction.repeatActionForever(loop), withKey: "blinkAction")

    }
    
    /***********************************************************
    Touching the Pet
    ************************************************************/
    func tapPet () {
        
    }
    
    /***********************************************************
        Feeding the Pet
    ************************************************************/
    func feedPet (food: GameScene.ItemType) -> Bool {
        switch food {
            case .FOOD_APPLE:
                happiness += 5;
                hunger += 10;
                
                if (happiness > 100) {
                    happiness = 100;
                }
                
                if (hunger > 100) {
                    hunger = 100;
                }
                return true;
            case .FOOD_CHOCOLATE:
                happiness += 15;
                hunger += 25;
                
                if (happiness > 100) {
                    happiness = 100;
                }
                
                if (hunger > 100) {
                    hunger = 100;
                }
                return true;
            default:
                return false;
        }
    }
    
    /***********************************************************
        Giving the Pet a Drink
    ************************************************************/
    func hydratePet (drink: GameScene.ItemType) -> Bool {
        switch drink {
            case .DRINK_WATER:
                thirst += 5;
                
                if (thirst > 100) {
                    thirst = 100;
                }
                return true;
            case .DRINK_JUICE:
                happiness += 10;
                thirst += 10;
                
                if (happiness > 100) {
                    happiness = 100;
                }
                
                if (thirst > 100) {
                    thirst = 100;
                }
                return true;
            default:
                return false;
        }
    }
    
    /***********************************************************
        Playing With the Pet
    ************************************************************/
    func playWith (toy: GameScene.ItemType) -> Bool {
        switch toy {
        case .TOY_BALL:
            happiness += 10
            fun += 15;

            if (happiness > 100) {
                happiness = 100;
            }
            
            if (fun > 100) {
                fun = 100;
            }
            return true;
        case .TOY_BOOK:
            happiness += 10;
            fun += 15;
            
            if (happiness > 100) {
                happiness = 100;
            }
            
            if (fun > 100) {
                fun = 100;
            }
            return true;
        default:
            return false;
        }
    }
}