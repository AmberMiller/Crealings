//
//  HelpScreen.swift
//  Crealings
//
//  Created by Amber Miller on 3/26/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import SpriteKit

class HelpScreen: SKNode {
    
    var helpScreen: SKSpriteNode? = nil;
    var nextButton: SKSpriteNode? = nil;
    var previousButton: SKSpriteNode? = nil;
    
    var dragSprite: SKSpriteNode? = nil;
    
    let helpArray: [String] = ["help1", "help2", "help3"];
    var currentIndex: Int = 0;
    
    func setup (view: GameScene) -> Bool {
        helpScreen = SKSpriteNode(imageNamed: helpArray[0]);
        let height = view.size.height / 1.5;
        helpScreen?.size = CGSizeMake(getRatioWidth(helpScreen!.size.width, height: helpScreen!.size.height, newHeight: height), height);
        helpScreen?.position = CGPointMake(view.size.width / 2, view.size.height / 2.5);
        helpScreen?.zPosition = 5;
    
        addNextButton();
        
        let exitButton: SKSpriteNode = SKSpriteNode(imageNamed: "exit_button");
        exitButton.position = CGPointMake(helpScreen!.size.width / 2, helpScreen!.size.height / 2.1);
        exitButton.name = "exitHelp";
        
        helpScreen?.addChild(exitButton);
        self.addChild(helpScreen!);
        
        return true;
    }
    
    func addNextButton () {
        nextButton = SKSpriteNode(imageNamed: "next_button");
        nextButton!.position = CGPointMake(helpScreen!.size.width / 2, 0.0);
        let nextHeight = helpScreen!.size.height / 3;
        nextButton?.size = CGSizeMake(getRatioWidth(nextButton!.size.width, height: nextButton!.size.height, newHeight: nextHeight), nextHeight);
        nextButton?.zPosition = 5;
        nextButton?.name = "next";

        helpScreen?.addChild(nextButton!);
    }
    
    func tapNext () {
        currentIndex += 1;
        helpScreen?.texture = SKTexture(imageNamed: helpArray[currentIndex]);
        
        if (currentIndex == helpArray.count - 1) {
            nextButton?.removeFromParent();
            nextButton = nil;
        }
        
        if (currentIndex == 1) {
            addDragAnim();
        } else {
            dragSprite?.removeFromParent();
        }
        
        if (previousButton == nil) {
            previousButton = SKSpriteNode(imageNamed: "previous_button");
            previousButton?.position = CGPointMake(-helpScreen!.size.width / 2, 0.0);
            let previousHeight = helpScreen!.size.height / 3;
            previousButton?.size = CGSizeMake(getRatioWidth(previousButton!.size.width, height: previousButton!.size.height, newHeight: previousHeight), previousHeight);
            previousButton?.zPosition = 5;
            previousButton?.name = "previous";
            
            helpScreen?.addChild(previousButton!);
        }
    }
    
    func tapPrevious () {
        currentIndex -= 1;
        helpScreen?.texture = SKTexture(imageNamed: helpArray[currentIndex]);
        
        if (currentIndex == 0) {
            previousButton?.removeFromParent();
            previousButton = nil;
        }
        
        if (currentIndex == 1) {
            addDragAnim();
        } else {
            dragSprite?.removeFromParent();
        }
        
        if (nextButton == nil) {
            addNextButton();
        }
    }
    
    func addDragAnim () {
        dragSprite = SKSpriteNode(imageNamed: "drag_item");
        dragSprite?.zPosition = 6;
        dragSprite?.size = CGSizeMake(dragSprite!.size.width / 1.4, dragSprite!.size.height / 1.4);
        let originalPositionX = helpScreen!.size.width / 4;
        let originalPositionY = -helpScreen!.size.height / 6;
        dragSprite!.position = CGPointMake(originalPositionX, originalPositionX);
        let dragAction = SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.moveTo(CGPointMake(-helpScreen!.size.width / 4, -helpScreen!.size.height / 5), duration: 1.0),
            SKAction.waitForDuration(1.0),
            SKAction.moveTo(CGPointMake(originalPositionX, originalPositionY), duration: 0.0)
        ]);
            
        dragSprite!.runAction(SKAction.repeatActionForever(dragAction));
            
        helpScreen!.addChild(dragSprite!);
    }
    
    func getRatioWidth (width: CGFloat, height: CGFloat, newHeight: CGFloat) -> CGFloat {
        let ratio: CGFloat = height / width; //Get original aspect ratio of image
        return (newHeight / ratio); //Return new height with aspect ratio
    }
    
}