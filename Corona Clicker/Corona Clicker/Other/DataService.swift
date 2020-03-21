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
    static let Items: [Item] = [
        Item.init(image: UIImage(named: Base.basicCorona)!, title: "Basic\n SARS-COV-2", coeffitient: 1, goal: 0),
        Item.init(image: UIImage(named: Base.rareCorona)!, title: "Rare\n SARS-COV-2", coeffitient: 2, goal: 1000),
        Item.init(image: UIImage(named: Base.toxicCorona)!, title: "Toxic\n SARS-COV-2", coeffitient: 3, goal: 100000)
    ]
}
