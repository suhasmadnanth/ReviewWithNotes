//
//  ReviewModel.swift
//  ReviewWithNotes
//
//  Created by Suhas Madnanth on 13/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ReviewModel {

    var reviewList = [Review]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func addItemPointsAndReviews(item : Item) {
        let newReview = Review(context: context)
        newReview.reviewPoints = item.itemPoints
        newReview.reviewNotes = item.itemNotes
        newReview.toParentItem = item
        reviewList.append(newReview)
        saveReview()
        print("List of saved reviews are \(reviewList)")
    }
    
    func saveReview(){
        do{
            try context.save()
        }catch{
            print("error saving context \(error)")
        }
    }
    
    
    func loadReview(item : Item){
        let request : NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "toParentItem.itemName MATCHES %@", item.itemName!)
        request.predicate = predicate
        do{
            reviewList = try context.fetch(request)
        }catch{
            print("Error fetching request \(error)")
        }
        
    }
}
