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
                } else {
                    println("Present Game Scene Delegate");
                    eggDelegate?.presentGameScene();
                }
            }
        }
    }
    
    func setupScene () {
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