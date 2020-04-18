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
    
    
    func loadReview(){
        let request : NSFetchRequest<Review> = Review.fetchRequest()
        do{
            reviewList = try context.fetch(request)
        }catch{
            print("Error fetching request \(error)")
        }
        print("Inside Load Review method. Array list is")
        for item in reviewList {
            print("review point is \(item.reviewPoints)")
            print("review notes is \(item.reviewNotes)")
        }
    }
}
