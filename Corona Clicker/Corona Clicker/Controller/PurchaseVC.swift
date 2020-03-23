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
    
    let item: Item! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
    }

    @IBAction func purchasePressed(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = item.purchaseID!
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            
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
