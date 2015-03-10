//
//  ChooseEggViewController.swift
//  Crealings
//
//  Created by Amber Miller on 3/10/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ChooseEggViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var eggArray: [EggObject] = [];
    var selectedCell: Int = Int();
    
    override func viewDidLoad() {
        eggArray.append(EggObject(_name: "purple", _image: UIImage(named: "pEgg")!));
        eggArray.append(EggObject(_name: "blue", _image: UIImage(named: "bEgg")!));
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: eggCell = collectionView.dequeueReusableCellWithReuseIdentifier("eggCell", forIndexPath: indexPath) as eggCell;
        
        let egg = eggArray[indexPath.row];
        
        cell.eggImage.image = egg.image;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eggArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCell = indexPath.row;
        self.performSegueWithIdentifier("choseEgg", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "choseEgg") {
            let gameData = segue.destinationViewController as GameViewController;
            let data: EggObject = eggArray[selectedCell];
            gameData.eggType = data.name;
        }
    }
    
}