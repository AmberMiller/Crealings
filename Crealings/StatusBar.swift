//
//  StatusBar.swift
//  Crealings
//
//  Created by Amber Miller on 3/9/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import SpriteKit

final class StatusBar : SKNode {
    
    var barSprite: SKSpriteNode? = nil;
    var statusSprite: SKSpriteNode? = nil;
    
    var gradientAtlas: SKTextureAtlas = SKTextureAtlas();
    
    let status: Status = Status.sharedInstance;
    
    var currentStatus: Int = 100;
    let maxStatus: Int = 100;
    let minStatus: Int = 0;
    
    /***********************************************************
        Set Up
    ************************************************************/
    func setup (view: GameHUD, current: String) -> Bool {
        gradientAtlas = SKTextureAtlas(named: "Gradient");
        barSprite = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(view.size.width / 6, view.size.height / 2));
        
        /* Set status bar sprite for each status as called */
        switch current {
            case "happiness":
                barSprite?.position = CGPointMake(0.0, -view.size.height + 2.0);
                barSprite?.name = "happiness";
                currentStatus = status.getHappiness();
            case "energy":
                barSprite?.position = CGPointMake(view.size.width / 6, -view.size.height + 2.0);
                barSprite?.name = "energy";
                currentStatus = status.getEnergy();
            case "hunger":
                barSprite?.position = CGPointMake((view.size.width / 6) * 2, -view.size.height + 2.0);
                barSprite?.name = "hunger";
                currentStatus = status.getHunger();
            case "thirst":
                barSprite?.position = CGPointMake((view.size.width / 6) * 3, -view.size.height + 2.0);
                barSprite?.name = "thirst";
                currentStatus = status.getThirst();
            case "fun":
                barSprite?.position = CGPointMake((view.size.width / 6) * 4, -view.size.height + 2.0);
                barSprite?.name = "fun";
                currentStatus = status.getFun();
            case "hygiene":
                barSprite?.position = CGPointMake((view.size.width / 6) * 5 - 2, -view.size.height + 2.0);
                barSprite?.name = "hygiene";
                currentStatus = status.getHygiene();
            default:
                println("Error: No Status Set");
        }
        
        barSprite?.anchorPoint = CGPointMake(0.0, 0.0);
        
        println("VIEW SIZE: \(view.size) BAR SPRITE SIZE: \(barSprite?.size)");
        
        /* Add status sprite with gradient image atlas to display current status */
        statusSprite = SKSpriteNode(texture: gradientAtlas.textureNamed("gradient_100"));
        statusSprite?.size = barSprite!.size;
        statusSprite?.position = CGPointMake(barSprite!.size.width / 2, barSprite!.size.height / 2);
        statusSprite?.zPosition = -1;
        setStatus(currentStatus);
        barSprite?.addChild(statusSprite!);
        
        self.addChild(barSprite!);
        
        return true;
    }
    
    /***********************************************************
        Set Status
    ************************************************************/
    
    /* Called to set image based on current status bar */
    func setStatusBar (name: String) {
        switch name {
        case "happiness":
//            println("Happiness Tapped");
            setStatus(status.getHappiness());
        case "energy":
//            println("Energy Tapped");
            setStatus(status.getEnergy());
        case "hunger":
//            println("Hunger Tapped");
            setStatus(status.getHunger());
        case "thirst":
//            println("Thirst Tapped");
            setStatus(status.getThirst());
        case "fun":
//            println("Fun Tapped");
            setStatus(status.getFun());
        case "hygiene":
//            println("Hygiene Tapped");
            setStatus(status.getHygiene());
        default:
            println("No Status Set");
        }
    }
    
    /* Set image based on closest in range */
    func setStatus (stat: Int) {
        switch stat {
            case 100:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_100");
            case 93...99:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_95");
            case 88...92:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_90");
            case 83...87:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_85");
            case 78...82:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_80");
            case 73...77:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_75");
            case 68...72:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_70");
            case 63...67:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_65");
            case 58...62:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_60");
            case 53...57:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_55");
            case 48...52:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_50");
            case 43...47:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_45");
            case 38...42:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_40");
            case 33...37:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_35");
            case 27...32:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_30");
            case 23...26:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_25");
            case 18...22:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_20");
            case 13...17:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_15");
            case 7...12:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_10");
            case 1...6:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_5");
            case 0:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_0");
            default:
                statusSprite?.texture = gradientAtlas.textureNamed("gradient_50");

        }
    }

}
