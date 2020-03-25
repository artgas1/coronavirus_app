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
    
    @IBOutlet weak var purchaseVirusImage: UIImageView!
    public var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = self.item as? Item else { return }
        self.purchaseVirusImage?.image = item.image
        SKPaymentQueue.default().add(self)
    }
    
    @IBAction func purchasePressed(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = item!.purchaseID
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
