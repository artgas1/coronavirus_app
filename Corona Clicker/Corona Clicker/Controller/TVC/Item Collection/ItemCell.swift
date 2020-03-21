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
        self.itemImage.image = item.image
        self.itemTitle.text = item.title
    }
}
