//
//  ReviewViewController.swift
//  ReviewWithNotes
//
//  Created by Suhas on 12/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    var selectedItem : Item?{
        didSet{
            print("Item name is: \(selectedItem!)")
        }
    }
    
    @IBOutlet weak var addPointsSlider: UISlider!
    @IBOutlet weak var showPointsSliderValue: UILabel!
    @IBOutlet weak var addReviewNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReviewNotes.layer.cornerRadius = addReviewNotes.frame.height / 10
       
    }
    
    @IBAction func addUISliderAction(_ sender: UISlider) {
        showPointsSliderValue.text = String(format: "\(Int(sender.value))")
    }
    
    
    
}


