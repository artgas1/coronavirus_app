//
//  CustimizeTVC.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import RealmSwift

class CustomizeTVC: UITableViewController {
    
    let titleBar = "TitleBar"
    let TVCCell = "TVCCell"
    
    let realm = RealmService.instance.realm
    
    var unlockedItems: List<RealmItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPurchaseObserver()
        observeRealmErrors()
        updateVirusStatuses()
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func addPurchaseObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.loadItems),
                                               name: .itemPurchased,
                                               object: nil)
    }
    
    func observeRealmErrors() {
        RealmService.instance.observeRealmErrors(in: self) { (error) in
            print(error ?? "")
        }
    }
    
    @objc func loadItems() {
        DataService.user = realm.objects(User.self).first
        updateVirusStatuses()
    }
    
    func updateVirusStatuses() {
        unlockedItems = DataService.user.availableViruses
        print(DataService.user!)
        
        for item in unlockedItems {
            DataService.items[item.id].isLocked = false
            DataService.items[item.id].contaigousness = item.contaigousness
            DataService.items[item.id].damage = item.damage
            DataService.items[item.id].mutation = item.mutation
        }
        self.tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Table view data source

    @objc func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: titleBar, for: indexPath) as! TitleCell
            cell.configure(title: "Customize")
            cell.backBtn.addTarget(self, action: #selector(self.backPressed), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVCCell, for: indexPath) as! TVCCell
            cell.configure(items: DataService.items)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 96
        } else {
            return CGFloat(self.view.frame.height) - 64.0
        }
    }
}
