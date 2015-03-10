//
//  GameViewController.swift
//  Crealings
//
//  Created by Amber Miller on 3/5/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController, EggSceneDelegate, GameSceneDelegate {
    
    var skView = SKView();
    var gameScene: GameScene? = nil;
    var eggScene: EggScene? = nil;
    
    var firstPlay: Bool = Bool();
    
    var eggType: String = String();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.showsDrawCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        if (!defaults.boolForKey("firstPlay")) {
            println("FIRST PLAY")
            firstPlay = true;
            presentEggScene();
        } else {
            println("CONTINUE")
            firstPlay = false;
            presentGameScene();
        }
    }
    
    func presentEggScene () {
        println("Present Egg Scene");
        eggScene = EggScene(size: view.bounds.size);
        
        eggScene!.eggDelegate = self;
        
        /* Set the scale mode to scale to fit the window */
        eggScene!.scaleMode = .AspectFill
        
        skView.presentScene(eggScene)
    }
    
    func presentGameScene () {
        println("Present Game Scene");
        gameScene = GameScene(size: view.bounds.size);
        
        gameScene?.gameDelegate = self;
        
        /* Set the scale mode to scale to fit the window */
        gameScene!.scaleMode = .AspectFill
        
        let fade: SKTransition = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 2.0);
        skView.presentScene(gameScene, transition: fade);
    }
    
    override func viewWillAppear(animated: Bool) {
        println("View Will Appear");
        if (firstPlay) {
            (skView.scene as EggScene).eggType = self.eggType;
            (skView.scene as EggScene).setupScene();
        }
    }
    
    func GameSceneSetup () {
        println("Game Scene Setup");
        (skView.scene as GameScene).currentMon = self.eggType;
        (skView.scene as GameScene).setUpScene();
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
