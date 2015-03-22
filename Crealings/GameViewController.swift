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
    
    let defaults = NSUserDefaults.standardUserDefaults();

    var skView = SKView();
    var firstPlay: Bool = Bool();
    var firstLoad: Bool = true;
    var eggType: String? = nil;
    
    override func viewWillAppear(animated: Bool) {
        
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
            presentGameScene("continue");
        }
    }
    
    /***********************************************************
     Scenes and Setup
    ************************************************************/
    
    func presentEggScene () {
        println("Present Egg Scene");
        let eggScene = EggScene(size: view.bounds.size);
        
        eggScene.eggDelegate = self;
        
        /* Set the scale mode to scale to fit the window */
        eggScene.scaleMode = .AspectFill
        
        skView.presentScene(eggScene)
    }
    
    func presentGameScene (from: String) {
        println("Present Game Scene");
        let gameScene = GameScene(size: view.bounds.size);
        
        gameScene.gameDelegate = self;
        
        /* Set the scale mode to scale to fit the window */
        gameScene.scaleMode = .AspectFill
        
        if (from == "eggScene") {
            gameScene.isNewGame = true;
        } else {
            gameScene.isNewGame = false;
        }

        if (firstLoad) {
            let fade: SKTransition = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 2.0);
            skView.presentScene(gameScene, transition: fade);
            
            firstLoad = false;
        }

    }
    
    /* Setup the Egg Scene */
    func EggSceneSetup () {
        println("Egg Scene Setup");
        if (eggType == nil) {
            eggType = defaults.valueForKey("userCrealing") as? String;
        }
        (skView.scene as EggScene).eggType = eggType;
        (skView.scene as EggScene).setupScene();
    }
    
    /* Setup the GameScene */
    func GameSceneSetup () {
        println("Game Scene Setup");
        if (eggType == nil) {
            eggType = defaults.valueForKey("userCrealing") as? String;
        }
        (skView.scene as GameScene).currentMon = eggType;
        (skView.scene as GameScene).setUpScene();
    }
    

    /***********************************************************
        Game Scene HUD Button Click Actions
    ************************************************************/
    
    func MenuButtonClicked () {
        println("Game Delegate: Menu");
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("StatsController") as StatsViewController;
        self.presentViewController(view, animated: true, completion: nil);
    }
    
    func ShopButtonClicked () {
        println("Game Delegate: Shop");
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("ShopController") as ShopViewController;
        self.presentViewController(view, animated: true, completion: nil);
    }
    
    func FightButtonClicked () {
        println("Game Delegate: Fight");
    }
    
    /***********************************************************
        Clear Game on Game Over
    ************************************************************/
    
    func clearGame () {
        defaults.setBool(false, forKey: "firstPlay");
        
        if (defaults.boolForKey("firstPlay")) {
            self.dismissViewControllerAnimated(true, completion: nil);
        } else {
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("StartController") as StartViewController;
            self.presentViewController(view, animated: true, completion: nil);
        }
    }
    
    /***********************************************************
        Setup
    ************************************************************/

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
