//
//  Item.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class Item {
    var image: UIImage!
    var title: String!
    
    required init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}
