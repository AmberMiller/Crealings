//
//  EggObject.swift
//  Crealings
//
//  Created by Amber Miller on 3/10/15.
//  Copyright (c) 2015 Amber Miller. All rights reserved.
//

import Foundation
import UIKit

class EggObject {
    
    var name: String = String();
    var image: UIImage = UIImage();
    
    init (_name: String, _image: UIImage) {
        name = _name;
        image = _image;
    }
}