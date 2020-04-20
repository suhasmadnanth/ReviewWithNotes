//
//  CustomCollectionViewCell.swift
//  ReviewWithNotes
//
//  Created by Suhas Madnanth on 19/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var previousReviewsTextView: UITextView!
    
    
    func configureCell(reviewItem : Review){
        previousReviewsTextView.layer.cornerRadius = previousReviewsTextView.frame.height / 7
        previousReviewsTextView.text = reviewItem.reviewNotes
        
       
    }
}
