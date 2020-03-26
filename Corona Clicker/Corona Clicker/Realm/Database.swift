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
    dynamic var availableViruses = List<RealmItem>()
    dynamic var premium: Bool = false
    
    convenience init(created: NSDate, score: Int = 0, goal: Int = 100, virusIndex: Int = 0, premium: Bool = false) {
        self.init()
        self.created = created
        self.score = score
        self.goal = goal
        self.virusIndex = virusIndex
        self.premium = premium
    }
}

@objcMembers class RealmItem: Object {
    dynamic var id: Int = 0
    dynamic var contaigousness: Int = 1
    dynamic var damage: Int = 0
    dynamic var mutation: Int = 0
    
    convenience init(id: Int, contaigousness: Int, damage: Int = 0, mutation: Int = 0) {
        self.init()
        self.id = id
        self.contaigousness = contaigousness
        self.damage = damage
        self.mutation = mutation
    }
}
