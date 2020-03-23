//
//  DataService.swift
//  Corona Clicker
//
//  Created by Андрей Хромов on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import Foundation
import UIKit

class DataService{
    static var currentItemID: Int = 0
    
    static let viruses: [Item] = [
        Item.init(image: Base.coronaImages[0], title: Base.basicCorona, goal: Base.levels[0]),
        Item.init(image: Base.coronaImages[1], title: Base.toxicCorona, goal: Base.levels[1]),
        Item.init(image: Base.coronaImages[2], title: Base.rareCorona, goal: Base.levels[2])
    ]
    
    static let items: [Item] = [
        Item.init(image: Base.coronaItemsImages[0], title: Base.basicCorona, goal: Base.levels[0]),
        Item.init(image: Base.coronaItemsImages[1], title: Base.toxicCorona, goal: Base.levels[1]),
        Item.init(image: Base.coronaItemsImages[2], title: Base.rareCorona, goal: Base.levels[2])
    ]
}
