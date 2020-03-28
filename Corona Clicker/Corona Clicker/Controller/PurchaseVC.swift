//
//  PurchaseVC.swift
//  Corona Clicker
//
//  Created by Андрей Хромов on 23.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseVC: UIViewController {
    
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
    
    func unlockItem(item: Item) {
        guard let id = DataService.items.firstIndex(where: { $0 === item }) else { return }
        let unlockedItem = RealmItem(id: id, contaigousness: item.contaigousness, damage: item.damage, mutation: item.mutation)
        RealmService.instance.add(item: unlockedItem)
        NotificationCenter.default.post(name: .itemPurchased, object: nil)
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
}


extension PurchaseVC: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            let productID = transaction.payment.productIdentifier
            print(transaction.transactionState.status(), productID)
            
            switch transaction.transactionState {
            case .purchasing, .deferred: break
            default:
                queue.finishTransaction(transaction)
                let item = DataService.items.first(where: { $0.purchaseID == productID })
                unlockItem(item: item!)
            }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}
