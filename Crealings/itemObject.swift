//
//  itemObject.swift
//  Crealings
//
//  Created by Amber Miller on 3/14/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import UIKit

class itemObject {
    
    var itemName: String = String();
    var itemType: GameScene.ItemType? = nil;
    var itemCost: Int = Int();
    var itemDescription: String = String();
    var itemImage: UIImage = UIImage();
    var itemImageName: String = String();
    
    init (_itemName: String, _itemType: GameScene.ItemType, _itemCost: Int, _itemDescription: String, _itemImage: String) {
        itemName = _itemName;
        itemType = _itemType;
        itemCost = _itemCost;
        itemDescription = _itemDescription;
        itemImage = UIImage(named: _itemImage)!;
        itemImageName = _itemImage;
    }
    
}