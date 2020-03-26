//
//  Database.swift
//  Corona Clicker
//
//  Created by Georg on 25.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class User: Object {
    dynamic var created: NSDate = Date() as NSDate
    dynamic var score: Int = 0
    dynamic var goal: Int = 100
    dynamic var virusIndex: Int = 0
    dynamic var availableViruses: String = ""
    dynamic var premium: Bool = false
    
    convenience init(created: NSDate, score: Int = 0, goal: Int = 100, virusIndex: Int = 0, availableViruses: String = "0", premium: Bool = false) {
        self.init()
        self.created = created
        self.score = score
        self.goal = goal
        self.virusIndex = virusIndex
        self.availableViruses = availableViruses
        self.premium = premium
    }
    
    public var vIndexes: [Int] {
        var indexes = [Int]()
        let str = self.availableViruses.components(separatedBy: " ")
        for i in str {
            let num = NumberFormatter().number(from: i)
            indexes.append(num!.intValue)
        }
        return indexes
    }
}
