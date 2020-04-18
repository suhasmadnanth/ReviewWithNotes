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
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemPointsAndReviewToAdd = [ReviewModel]()
    var reviewModel = ReviewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReviewNotes.layer.cornerRadius = addReviewNotes.frame.height / 10
        reviewModel.loadReview()
    }
    
    @IBAction func addUISliderAction(_ sender: UISlider) {
        showPointsSliderValue.text = String(format: "\(Int(sender.value))")
    }
    
    
    @IBAction func addPointsAndReviews(_ sender: UIButton) {
        if addPointsSlider.value > 0.0 {
            selectedItem?.itemPoints = Int64(addPointsSlider.value)
        }
        if addReviewNotes.text != "" {
                selectedItem?.itemNotes = addReviewNotes.text
        }
        reviewModel.addItemPointsAndReviews(item: selectedItem!)
            do{
                try context.save()
            }catch{
                print("error saving context \(error)")
            }
    }
    
    
}


