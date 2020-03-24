//
//  ItemCell.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    var item: Item!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(item: Item) {
        self.item = item
        if item.isLocked != true {
            self.itemImage.image = item.image
        } else {
            self.itemImage.image = Base.lockedCoronaImage
        }
        self.itemTitle.text = item.title
    }
    
    public func animateSelection() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.itemImage.scaleOutIn(duration: 0.2, delay: 0, scaleX: 1.1, scaleY: 1.1)
            self.itemTitle.textColor = UIColor.red
        }, completion: nil)
    }
    
    public func deselect() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.itemTitle.textColor = UIColor.white
        }, completion: nil)
    }
}
