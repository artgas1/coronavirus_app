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
    var coeffitient: Int!
    var goal: Int!
    
    required init(image: UIImage, title: String, coeffitient: Int, goal: Int) {
        self.image = image
        self.title = title
        self.coeffitient = coeffitient
        self.goal = goal
    }
}
