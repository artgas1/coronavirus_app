//
//  TVCCell.swift
//  Corona Clicker
//
//  Created by Georg on 21.03.2020.
//  Copyright © 2020 Georg. All rights reserved.
//

import UIKit

class TVCCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var items: [Item]!
    let itemId = "Item"
    
    let inset: CGFloat = 0
    let minimumLineSpacing: CGFloat = 0
    let minimumInteritemSpacing: CGFloat = 0
    let cellsPerRow = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    public func configure(items: [Item]) {
        self.items = items
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        markSelectedItem()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func markSelectedItem() {
        let currentCellIP = IndexPath(row: DataService.currentItemID, section: 0)
        if let cell = collectionView.cellForItem(at: currentCellIP) as? ItemCell {
            cell.itemTitle.textColor = .red
        }
    }

}

extension TVCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemId, for: indexPath) as! ItemCell
        cell.configure(item: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: - TODO: Add selected implementation
        if items[indexPath.item].isLocked != true {
            let currentCellIP = IndexPath(row: DataService.currentItemID, section: 0)
            if let cell = collectionView.cellForItem(at: currentCellIP) as? ItemCell {
                cell.itemTitle.textColor = .white
            }
            
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.animateSelection()
                DataService.currentItemID = indexPath.item
                NotificationCenter.default.post(name: .updateVirus, object: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if items[indexPath.item].isLocked != true {
            if let cell = collectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.deselect()
            }
        }
    }
}
