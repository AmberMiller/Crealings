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
    var itemType: UsableItem.ItemType? = nil;
    var itemCost: Int = Int();
    var itemDescription: String = String();
    var itemImage: UIImage = UIImage();
    var itemImageName: String = String();
    var happinessChange: Int = Int();
    var energyChange: Int = Int();
    var hungerChange: Int = Int();
    var thirstChange: Int = Int();
    var funChange: Int = Int();
    var hygieneChange: Int = Int();
    
    init (_itemName: String, _itemType: UsableItem.ItemType, _itemCost: Int, _itemDescription: String, _itemImage: String, _happinessChange: Int, _energyChange: Int, _hungerChange: Int, _thirstChange: Int, _funChange: Int, _hygieneChange: Int) {
        itemName = _itemName;
        itemType = _itemType;
        itemCost = _itemCost;
        itemDescription = _itemDescription;
        itemImage = UIImage(named: _itemImage)!;
        itemImageName = _itemImage;
        happinessChange = _happinessChange;
        energyChange = _energyChange;
        hungerChange = _hungerChange;
        thirstChange = _thirstChange;
        funChange = _funChange;
        hygieneChange = _hygieneChange;
    }
    
}