//
//  PurchaseVC.swift
//  Corona Clicker
//
//  Created by Андрей Хромов on 23.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseVC: UIViewController, SKPaymentTransactionObserver {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var purchaseBtn: UIButton!
    @IBOutlet weak var purchaseVirusImage: UIImageView!
    public var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SKPaymentQueue.default().add(self)
    }
    
    func setupUI() {
        guard let item = self.item as? Item else { return }
        itemName.text = item.title
        itemName.textAlignment = .center
        self.purchaseVirusImage?.image = item.image
        self.purchaseBtn.titleLabel?.font = UIFont(name: "Bungee-Regular", size: 16)
        self.purchaseBtn.cornerRadius = 5.0
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func purchasePressed(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = item!.purchaseID!
            SKPaymentQueue.default().add(paymentRequest)
        } 
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
            } else if transaction.transactionState == .failed {
                
            }
        }
    }

}
