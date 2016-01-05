//
//  Egg.swift
//  Crealings
//
//  Created by Amber Miller on 3/10/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

class Egg: SKNode {
    
    let game: GameScene = GameScene();
    
    var eggSprite: SKSpriteNode? = nil;
    
    var animAtlas: SKTextureAtlas? = nil;
    var eggAnimTextures: [SKTexture] = [];
    var eggAnim: SKAction = SKAction();
    
    var eggImages: [String] = [];
    let pEggImages = ["pEgg_new", "pEgg_crack1", "pEgg_crack2", "pEgg_crack3"];
    let bEggImages = ["bEgg_new", "bEgg_crack1", "bEgg_crack2", "bEgg_crack3"];
    
    /***********************************************************
        Setup
    ************************************************************/
    
    func setup (view: EggScene, type: String) -> Bool {
        switch type {
            case "purple":
                eggImages = pEggImages;
            case "blue":
                eggImages = bEggImages;
            default:
                println("Error: No Egg");
        }
        
        setEgg(0);
        eggSprite?.position = CGPointMake(view.size.width / 2, view.size.height / 3.5);
        eggSprite?.name = "egg";
        self.addChild(eggSprite!);
        return true;
    }
    
    func setEgg (numTaps: Int) {
        var egg1: SKTexture = SKTexture();
        var egg2: SKTexture = SKTexture();
        var egg3: SKTexture = SKTexture();
        
        /* Set egg image animation based on numTaps */
        switch numTaps {
            case 0:
                animAtlas = SKTextureAtlas(named: eggImages[0]);
                egg1 = animAtlas!.textureNamed("egg1");
                egg2 = animAtlas!.textureNamed("egg2");
                egg3 = animAtlas!.textureNamed("egg3");
            case 1:
                animAtlas = SKTextureAtlas(named: eggImages[1]);
                egg1 = animAtlas!.textureNamed("egg1_crack1");
                egg2 = animAtlas!.textureNamed("egg2_crack1");
                egg3 = animAtlas!.textureNamed("egg3_crack1");
            case 2:
                animAtlas = SKTextureAtlas(named: eggImages[2]);                
                egg1 = animAtlas!.textureNamed("egg1_crack2");
                egg2 = animAtlas!.textureNamed("egg2_crack2");
                egg3 = animAtlas!.textureNamed("egg3_crack2");
            case 3:
                animAtlas = SKTextureAtlas(named: eggImages[3]);
                egg1 = animAtlas!.textureNamed("egg1_crack3");
                egg2 = animAtlas!.textureNamed("egg2_crack3");
                egg3 = animAtlas!.textureNamed("egg3_crack3");
            default:
                break;
        }
        
        eggAnimTextures = [egg1, egg2, egg1, egg3, egg1];
        eggAnim = SKAction.animateWithTextures(eggAnimTextures, timePerFrame: 0.1);

        if (eggSprite == nil) {
            eggSprite = SKSpriteNode(texture: eggAnimTextures[0]);
        }
        
        let loop = SKAction.sequence([eggAnim, SKAction.waitForDuration(2)])
        eggSprite!.runAction(SKAction.repeatActionForever(loop), withKey: "eggAnim")
    }
}