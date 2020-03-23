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
    
    static let items: [Item] = [
        Item.init(image: UIImage(named: Base.basicCorona)!, title: "Basic\n SARS-COV-2", goal: 0),
        Item.init(image: UIImage(named: Base.rareCorona)!, title: "Rare\n SARS-COV-2", goal: 1000),
        Item.init(image: UIImage(named: Base.toxicCorona)!, title: "Toxic\n SARS-COV-2", goal: 100000)
    ]
}
