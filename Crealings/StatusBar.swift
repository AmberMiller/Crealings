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
    func setup (view: GameScene, current: String) -> Bool {
        gradientAtlas = SKTextureAtlas(named: "Gradient");
        
        switch current {
        case "happiness":
            barSprite = SKSpriteNode(imageNamed: "bar_happiness");
            barSprite?.position = CGPointMake(view.size.width / 2 - 200.0, view.size.height - 30.0);
            barSprite?.name = "happiness";
            currentStatus = status.getHappiness();
        case "energy":
            barSprite = SKSpriteNode(imageNamed: "bar_energy");
            barSprite?.position = CGPointMake(view.size.width / 2 - 200.0, view.size.height - 75.0);
            barSprite?.name = "energy";
            currentStatus = status.getEnergy();
        case "hunger":
            barSprite = SKSpriteNode(imageNamed: "bar_hunger");
            barSprite?.position = CGPointMake(view.size.width / 2, view.size.height - 30.0);
            barSprite?.name = "hunger";
            currentStatus = status.getHunger();
        case "thirst":
            barSprite = SKSpriteNode(imageNamed: "bar_thirst");
            barSprite?.position = CGPointMake(view.size.width / 2, view.size.height - 75.0);
            barSprite?.name = "thirst";
            currentStatus = status.getThirst();
        case "fun":
            barSprite = SKSpriteNode(imageNamed: "bar_fun");
            barSprite?.position = CGPointMake(view.size.width / 2 + 200.0, view.size.height - 30.0);
            barSprite?.name = "fun";
            currentStatus = status.getFun();
        case "hygiene":
            barSprite = SKSpriteNode(imageNamed: "bar_hygiene");
            barSprite?.position = CGPointMake(view.size.width / 2 + 200.0, view.size.height - 75.0);
            barSprite?.name = "hygiene";
            currentStatus = status.getHygiene();
        default:
            println("Error: No Status Set");
        }
        
        barSprite?.anchorPoint = CGPointMake(0.5, 0.5);
        
        statusSprite = SKSpriteNode(texture: gradientAtlas.textureNamed("gradient_100"));
        statusSprite?.zPosition = -1;
        setStatus(currentStatus);
        barSprite?.addChild(statusSprite!);
        
        self.addChild(barSprite!);
        
        return true;
    }
    
    /***********************************************************
        Set Status
    ************************************************************/
    
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
    
    /***********************************************************
        Tap Bar
    ************************************************************/
    
    func tapStatusBar (name: String) {
        switch name {
            case "happiness":
                println("Happiness Tapped");
                status.setHappiness(10);
                setStatus(status.getHappiness());
            case "energy":
                println("Energy Tapped");
                status.setEnergy(10);
                setStatus(status.getEnergy());
            case "hunger":
                println("Hunger Tapped");
                status.setHunger(10);
                setStatus(status.getHunger());
            case "thirst":
                println("Thirst Tapped");
                status.setThirst(10);
                setStatus(status.getThirst());
            case "fun":
                println("Fun Tapped");
                status.setFun(10);
                setStatus(status.getFun());
            case "hygiene":
                println("Hygiene Tapped");
                status.setHygiene(10);
                setStatus(status.getHygiene());
            default:
                println("Bar Tap?");
        }
    }
}
