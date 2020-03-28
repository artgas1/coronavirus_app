//
//  Constants.swift
//  Corona Clicker
//
//  Created by Georg on 18.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

public struct Base {
    static let launchKey = "launchedBefore"
    
    static let created = "created"
    static let score = "score"
    static let goal = "goal"
    static let virusIndex = "virusIndex"
    static let availableViruses = "availableViruses"
    static let premium = "premium"
    
    static public let basicCorona = "Basic\nVirus"
    static public let toxicCorona = "Toxic\nVirus"
    static public let rareCorona = "Rare\nVirus"
    static public let lockedCorona = "Locked\nVirus"

    static let coronaImages: [UIImage] = [
        UIImage(named: "corona")!,
        UIImage(named: "ToxicCorona1")!,
        UIImage(named: "RareCorona1")!,
    ]
    
    static let coronaItemsImages: [UIImage] = [
        UIImage(named: "BasicCorona")!,
        UIImage(named: "ToxicCorona")!,
        UIImage(named: "RareCorona")!,
    ]
    
    static let coronaProductsID: [String] = [
        "georgefed.CoronaClicker.ToxicVirus",
        "georgefed.CoronaClicker.RareVirus",
    ]
    
    static let lockedCoronaImage: UIImage = UIImage(named: "LockedVirus")!
    
    static let levels:[Int] = [100,
                               1000,
                               1000,
    ]
    
    static let virusColors: [UIColor] = [#colorLiteral(red: 0.6117647059, green: 0.1215686275, blue: 0.1450980392, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.6117647059, blue: 0.168627451, alpha: 1), #colorLiteral(red: 0.5450980392, green: 0.1215686275, blue: 0.6117647059, alpha: 1)]
}

extension Notification.Name {
    static let updateVirus = Notification.Name("Update Virus")
    static let realmError = Notification.Name("Realm Error")
    static let itemPurchased = Notification.Name("Item Purchased")
}
