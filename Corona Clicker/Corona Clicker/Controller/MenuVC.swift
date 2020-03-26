//
//  MenuVC.swift
//  Corona Clicker
//
//  Created by Georg on 20.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import RealmSwift

class MenuVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var customizeBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        setupUI()
    }
    
    func setupUI() {
        continueBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 16.0)
        continueBtn.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.1450980392, alpha: 1)
        customizeBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 16.0)
        customizeBtn.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.1450980392, alpha: 1)
        aboutBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 16.0)
        aboutBtn.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.1450980392, alpha: 1)
    }
    
    //  MARK: - Actions
    @IBAction func continuePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func customizePressed(_ sender: Any) {
        
    }
    
    @IBAction func aboutPressed(_ sender: Any) {
        
    }
}
