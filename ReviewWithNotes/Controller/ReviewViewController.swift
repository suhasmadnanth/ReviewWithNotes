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
    
    
    
    @IBOutlet weak var previousReviewsCollectionView: UICollectionView!
    @IBOutlet weak var addPointsSlider: UISlider!
    @IBOutlet weak var showPointsSliderValue: UILabel!
    @IBOutlet weak var addReviewNotes: UITextView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemPointsAndReviewToAdd = [ReviewModel]()
    var reviewModel = ReviewModel()
    @IBOutlet weak var previousReviewLabel: UILabel!
    @IBOutlet weak var previousReviewView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReviewNotes.layer.cornerRadius = addReviewNotes.frame.height / 10
        reviewModel.loadReview(item: selectedItem!)
        previousReviewView.layer.cornerRadius = previousReviewView.frame.height / 10
        previousReviewLabel.text = "\(String(describing: selectedItem?.itemName)) previous review:"
        
    }
    
    @IBAction func addUISliderAction(_ sender: UISlider) {
        showPointsSliderValue.text = String(format: "\(Int(sender.value))")
    }
    
    
    @IBAction func addPointsAndReviews(_ sender: UIButton) {
        if addPointsSlider.value > 0.0 {
            selectedItem?.itemPoints += Int64(addPointsSlider.value)
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


extension ReviewViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewModel.reviewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.configureCell(reviewItem: reviewModel.reviewList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 201, height: 81)
    }
    
}
