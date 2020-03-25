//
//  Item.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class Item {
    private(set) var image: UIImage!
    private(set) var title: String!
    private(set) var goal: Int!
    
    public var contaigousness: Int = 1
    public var damage: Int = 1
    public var mutation: Int = 1
    
    public var isLocked: Bool!
    public var purchaseID: String!
    
    required init(image: UIImage, title: String, goal: Int, purchaseID: String = "", isLocked: Bool = false) {
        self.image = image
        self.title = title
        self.goal = goal
        self.purchaseID = purchaseID
        self.isLocked = isLocked
    }
}
