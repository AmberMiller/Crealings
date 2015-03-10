//
//  EggScene.swift
//  Crealings
//
//  Created by Amber Miller on 3/10/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import SpriteKit

protocol EggSceneDelegate {
    func presentGameScene()
}

class EggScene: SKScene {
    
    var eggDelegate: EggSceneDelegate?;
    var egg: Egg? = nil;
    
    var eggType: String? = nil;
    var numTaps: Int = 0;
    
    let soundFX: SoundFX = SoundFX();
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self);
            let node = nodeAtPoint(location);
            
            if (node.name == "egg") {
                if (numTaps < 3) {
                    numTaps += 1;
                    println("Num Taps: \(numTaps)");
                    egg?.setEgg(numTaps);
                    soundFX.playTapEgg();
                } else {
                    println("Present Game Scene Delegate");
                    soundFX.playTriangle();
                    eggDelegate?.presentGameScene();
                }
            }
        }
    }
    
    func setupScene () {
        let bg: SKSpriteNode = SKSpriteNode(imageNamed: "background1");
        bg.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        bg.zPosition = -2;
        self.addChild(bg);

        egg = Egg();
        if (eggType != nil) {
            if ((egg != nil) && (egg!.setup(self, type: eggType!))) {
                self.addChild(egg!);
            }
        } else {
            println("EGGSCENE: NO DATA");
        }
    }
    
}