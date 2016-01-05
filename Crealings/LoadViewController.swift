//
//  LoadViewController.swift
//  Crealings
//
//  Created by Amber Miller on 3/9/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import UIKit

class LoadViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults();
        
        if (defaults.boolForKey("firstPlay")) {
            println("FIRST PLAY")
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("NewGameController") as NewGameViewController;
            self.presentViewController(view, animated: true, completion: nil);
        } else {
            println("CONTINUE")
            let view = self.storyboard?.instantiateViewControllerWithIdentifier("GameController") as GameViewController;
            self.presentViewController(view, animated: true, completion: nil);
        }
    }
    
}