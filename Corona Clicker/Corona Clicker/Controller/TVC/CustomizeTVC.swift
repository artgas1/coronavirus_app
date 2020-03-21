//
//  CustimizeTVC.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class CustomizeTVC: UITableViewController {
    
    let titleBar = "TitleBar"
    let TVCCell = "TVCCell"
    
    let defaultItems: [Item] = [
        Item.init(image: UIImage(named: Base.basicCorona)!, title: "Basic\n SARS-COV-2"),
        Item.init(image: UIImage(named: Base.rareCorona)!, title: "Rare\n SARS-COV-2"),
        Item.init(image: UIImage(named: Base.toxicCorona)!, title: "Toxic\n SARS-COV-2")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
            cell.configure(items: defaultItems)
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
