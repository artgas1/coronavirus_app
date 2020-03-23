//
//  Constants.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

public struct Base {
    static public let basicCorona = "BasicCorona"
    static public let toxicCorona = "ToxicCorona"
    static public let rareCorona = "RareCorona"
    static public let lockedCorona = "LockedCorona"

    static let coronaImages: [UIImage] = [
        UIImage(named: "corona")!,
        UIImage(named: "RareCorona1")!,
        UIImage(named: "ToxicCorona1")!
    ]
    
    static let coronaItemsImages: [UIImage] = [
        UIImage(named: "BasicCorona")!,
        UIImage(named: "RareCorona")!,
        UIImage(named: "ToxicCorona")!
    ]
    
    static let lockedCoronaImage: UIImage = UIImage(named: "LockedCorona")!
}
