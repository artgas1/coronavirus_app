//
//  Constants.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

public struct Base {
    static public let basicCorona = "Basic\nVirus"
    static public let toxicCorona = "Toxic\nVirus"
    static public let rareCorona = "Rare\nVirus"
    static public let lockedCorona = "Locked\nVirus"

    static let coronaImages: [UIImage] = [
        UIImage(named: "corona")!,
        UIImage(named: "ToxicCorona1")!,
        UIImage(named: "RareCorona1")!
    ]
    
    static let coronaItemsImages: [UIImage] = [
        UIImage(named: "BasicCorona")!,
        UIImage(named: "ToxicCorona")!,
        UIImage(named: "RareCorona")!
    ]
    
    static let lockedCoronaImage: UIImage = UIImage(named: "LockedVirus")!
    
    static let levels:[Int] = [100, 1000, 1000]
}

extension Notification.Name {
    static let updateVirus = Notification.Name("Update Virus")
}
