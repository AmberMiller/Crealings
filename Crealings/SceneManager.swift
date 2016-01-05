//
//  SceneManager.swift
//  Crealings
//
//  Created by Amber Miller on 3/12/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import SpriteKit

class SceneManager {
    enum SceneType: UInt32 {
        case EggScene = 0
        case GameScene
    }
    
    func SceneFactory (sceneType: SceneType) -> SKScene? {
        if (sceneType == SceneType.EggScene) {
            return EggScene();
        } else if (sceneType == SceneType.GameScene) {
            return GameScene();
        }
        return nil;
    }
    
    var currentScene: SKScene? = nil;
    
    func startUpScene () {
        currentScene = SceneFactory(SceneType.EggScene);
    }
    
    func moveToScene (sceneType: SceneType) {
        var nextScene: SKScene? = SceneFactory(sceneType)!;
        
        if ((nextScene != nil) && (currentScene != nil)) {
            currentScene?.view?.presentScene(nextScene);
        }
    }
}