//
//  ItemsTableViewCell.swift
//  ReviewWithNotes
//
//  Created by Suhas on 12/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemsImageView: UIImageView!
    @IBOutlet weak var itemPoints: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    
    func configureCell(itemToBeConfigured: Item){
        itemName.text = itemToBeConfigured.itemName
        itemPoints.text = "\(itemToBeConfigured.itemPoints)"
        itemsImageView.image = UIImage(named: "letter-s")
    }

}
