//
//  Crealing.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

final class Crealing : SKNode {
    
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
    
    enum Gender: UInt32 {
        case MALE = 0
        case FEMALE
    }
    
    enum Personality: UInt32 {
        case ENERGETIC = 0
    }
    
    let gameScene = GameScene.sharedInstance;
    
    var view: GameScene? = nil;

    var crealingSprite: SKSpriteNode? = nil;
    var tombStoneSprite: SKSpriteNode? = nil;
    var animAtlas: SKTextureAtlas? = nil;
    var blinkAnimTextures: [SKTexture] = [];
    var blinkAnim: SKAction = SKAction();
    
    var isAlive: Bool = Bool();
    
    var age: Int = 0;

    var str: Int = 5;
    var dex: Int = 5;
    var con: Int = 10;
    
    var maxHealth: Int = 0;
    var currentHealth: Int = 0;
    
    let status: Status = Status.sharedInstance;
    
    var idle: Bool = true;
    
    var moodTotal: Int = 100;
    
    var crealingImages: [String] = [];
    let pHatchlingImages = ["pVeryHappy", "pMoreHappy", "pHappy", "pNeutral", "pUnhappy", "pSad", "pVerySad", "pDying"];
    let bHatchlingImages = ["bVeryHappy", "bMoreHappy", "bHappy", "bNeutral", "bUnhappy", "bSad", "bVerySad", "bDying"];

    
    /***********************************************************
        Set Up
    ************************************************************/
    func setup (_view: GameScene, mon: String) -> Bool {
        
        view = _view;
        
        switch mon {
            case "purple":
                crealingImages = pHatchlingImages;
            case "blue":
                crealingImages = bHatchlingImages;
            default:
                println("Error: No Crealing Set");
        }
        setMood(getMood())

        if (isAlive) {
            crealingSprite?.position = CGPointMake(view!.size.width / 2, view!.size.height / 3.2);
            crealingSprite?.name = "crealing";
            crealingSprite?.physicsBody = SKPhysicsBody(rectangleOfSize: crealingSprite!.size);
            crealingSprite?.physicsBody?.dynamic = false;
            crealingSprite?.physicsBody?.usesPreciseCollisionDetection = true;
            crealingSprite?.physicsBody?.categoryBitMask = GameScene.CollisionType.CREALING.rawValue;
            crealingSprite?.physicsBody?.contactTestBitMask = GameScene.CollisionType.ITEM.rawValue;
            self.addChild(crealingSprite!);
        }

        return true;
    }
    
    func isDead () {
        crealingSprite?.removeFromParent();
        crealingSprite = nil;
        
        tombStoneSprite = SKSpriteNode(imageNamed: "dead");
        tombStoneSprite?.position = CGPointMake(view!.size.width / 2, view!.size.height / 3.2);
        tombStoneSprite?.name = "crealing";
        
        self.addChild(tombStoneSprite!);
    }
    
    /***********************************************************
        Crealing Mood
    ************************************************************/
    
    //Set mood based on current stats
    func getMood () -> Mood {
        var mood: Mood;
        let moodTotal = status.getMoodTotal();
        
        if (moodTotal > 0) {
            isAlive = true;
        }
        
        println("Mood Total: \(moodTotal)")
        switch moodTotal {
            case 90...100:
                println("VERY HAPPY");
                mood = Mood.VERY_HAPPY;
            case 79...89:
                mood = Mood.MORE_HAPPY;
            case 65...78:
                mood = Mood.HAPPY;
            case 50...64:
                mood = Mood.NEUTRAL;
            case 40...49:
                mood = Mood.UNHAPPY;
            case 26...39:
                mood = Mood.SAD;
            case 15...25:
                mood = Mood.VERY_SAD;
            case 1...14:
                mood = Mood.DYING;
            case 0:
                mood = Mood.DEAD;
                isAlive = false;
            default:
                mood = Mood.NEUTRAL;
        }
        return mood;
    }
    
    func setMood (mood: Mood) {
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
        case .DEAD:
            isDead();
            return;
        default:
            animAtlas = SKTextureAtlas(named: crealingImages[3]);
            moodName = "neutral"
        }
        
        blinkAnimTextures.removeAll();
        
        //Loop through atlas forward and back for animation sequence
        let atlasNum = animAtlas!.textureNames.count / 3;
        for (var i = 1; i < atlasNum; i++) {
            let name = moodName + "\(i)"
            
            blinkAnimTextures.append(self.animAtlas!.textureNamed(name)!)
        }
        for (var i = atlasNum; i > 0; i--) {
            let name = moodName + "\(i)"
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
    
    /***********************************************************
        Animations
    ************************************************************/
    
    //Run animation with wait time and loop forever
    func runBlinkAnim () {
        var loop: SKAction;
        var loopAnimTextures: [SKTexture] = [];
        
        //If very happy, sad or very sad, loop first two images before running blinkAnim
        switch getMood() {
            case Mood.VERY_HAPPY:
                loopAnimTextures = [animAtlas!.textureNamed("vhappy1"), animAtlas!.textureNamed("vhappy2")];
                let loopAnim = SKAction.animateWithTextures(loopAnimTextures, timePerFrame: 0.1);
                
                loop = SKAction.sequence([
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    blinkAnim
                ]);
        case Mood.SAD:
                loopAnimTextures = [animAtlas!.textureNamed("sad1"), animAtlas!.textureNamed("sad2")];
                let loopAnim = SKAction.animateWithTextures(loopAnimTextures, timePerFrame: 0.1);
                
                loop = SKAction.sequence([
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    blinkAnim
                ]);
        case Mood.VERY_SAD:
                loopAnimTextures = [animAtlas!.textureNamed("cry1"), animAtlas!.textureNamed("cry2")];
                let loopAnim = SKAction.animateWithTextures(loopAnimTextures, timePerFrame: 0.1);
                
                loop = SKAction.sequence([
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    loopAnim, loopAnim, loopAnim, loopAnim,
                    blinkAnim
                ]);
        default:
            loop = SKAction.sequence([blinkAnim, SKAction.waitForDuration(5)])
        }
        
        //Run animation and repeat
        crealingSprite?.runAction(SKAction.repeatActionForever(loop), withKey: "blinkAction")
    }
    
    /***********************************************************
        Touching the Pet
    ************************************************************/
    func tapPet () -> Bool {
        println("Tapped Pet");
        status.setHappiness(5);
        
        return true;
    }
    
    func giveItem (happiness: Int, energy: Int, hunger: Int, thirst: Int, fun: Int, hygiene: Int) -> Bool {
        status.setHappiness(happiness);
        status.setEnergy(energy);
        status.setHunger(hunger);
        status.setThirst(thirst);
        status.setFun(fun);
        status.setHygiene(hygiene);
        
        return true;
    }
}