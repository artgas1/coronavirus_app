//
//  RealmService.swift
//  Corona Clicker
//
//  Created by Georg on 26.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import RealmSwift

class RealmService {
    static let instance = RealmService()
    
    let realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: .realmError, object: error)
    }
    
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: .realmError, object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingRealmErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: .realmError, object: nil)
    }
}
