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
    
    @IBOutlet weak var eggChooser: UICollectionView!
    
    let defaults = NSUserDefaults.standardUserDefaults();

    var eggArray: [EggObject] = [];
    var selectedCell: Int = Int();
    
    override func viewDidLoad() {
        eggArray.append(EggObject(_name: "purple", _image: UIImage(named: "pEgg")!));
        eggArray.append(EggObject(_name: "blue", _image: UIImage(named: "bEgg")!));
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: itemCell = collectionView.dequeueReusableCellWithReuseIdentifier("eggCell", forIndexPath: indexPath) as itemCell;
        
        let egg = eggArray[indexPath.row];
        
        cell.itemImage.image = egg.image;
        
        let height: CGFloat = collectionView.frame.height - 40.0;
        cell.frame.size = CGSizeMake(height, height);
        cell.center.y = collectionView.frame.size.height / 2;
        
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
            
            defaults.setValue(data.name, forKey: "userCrealing");
        }
    }
    
}