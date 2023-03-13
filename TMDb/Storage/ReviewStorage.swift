//
//  ReviewStorage.swift
//  TMDb
//
//  Created by imsyf on 3/13/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit
import CoreData

class ReviewStorage: NSObject {
    
    let reviewEntityName = "ReviewEntity"
    
    func getAll() -> [Review] {
        var reviews = [Review]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: reviewEntityName)
        
        do {
            let result = try manageContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in result {
                reviews.append(
                    Review(
                        id: data.value(forKey: "review_id") as? Int,
                        name: data.value(forKey: "review_name") as? String,
                        comment: data.value(forKey: "review_comment") as? String,
                        movieId: data.value(forKey: "review_movie_id") as? Int
                    )
                )
            }
        } catch let err {
            print(err)
        }
        
        return reviews
    }
    
    func getByMovieId(movieId: Int) -> [Review] {
        var reviews = [Review]()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let manageContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: reviewEntityName)
//        fetchRequest.predicate = NSPredicate(format: "review_id = %d", review.id!)
//
//        do {
//            let fetch = try manageContext.fetch(fetchRequest)
//            let update = fetch[0] as! NSManagedObject
//            update.setValue(review.id, forKey: "review_id")
//            update.setValue(review.name, forKey: "review_name")
//            update.setValue(review.comment, forKey: "review_comment")
//            update.setValue(review.movieId, forKey: "review_movie_id")
//
//            try manageContext.save()
//        } catch let error {
//            print(error)
//        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: reviewEntityName)
        fetchRequest.predicate = NSPredicate(format: "review_movie_id = %d", movieId)
        
        do {
            let result = try manageContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in result {
                reviews.append(
                    Review(
                        id: data.value(forKey: "review_id") as? Int,
                        name: data.value(forKey: "review_name") as? String,
                        comment: data.value(forKey: "review_comment") as? String,
                        movieId: data.value(forKey: "review_movie_id") as? Int
                    )
                )
            }
        } catch let err {
            print(err)
        }
        
        return reviews
    }
    
    func save(review: Review) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: reviewEntityName, in: manageContext)
        
        let insert = NSManagedObject(entity: entity!, insertInto: manageContext)
        insert.setValue(review.id, forKey: "review_id")
        insert.setValue(review.name, forKey: "review_name")
        insert.setValue(review.comment, forKey: "review_comment")
        insert.setValue(review.movieId, forKey: "review_movie_id")
        
        UserDefaults.standard.set(review.id, forKey: "LAST_SAVED_REVIEW_ID")
        
        do {
            try manageContext.save()
        } catch let error {
            print(error)
        }
        
    }
    
    func update(review: Review) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: reviewEntityName)
        fetchRequest.predicate = NSPredicate(format: "review_id = %d", review.id!)
        
        do {
            let fetch = try manageContext.fetch(fetchRequest)
            let update = fetch[0] as! NSManagedObject
            update.setValue(review.id, forKey: "review_id")
            update.setValue(review.name, forKey: "review_name")
            update.setValue(review.comment, forKey: "review_comment")
            update.setValue(review.movieId, forKey: "review_movie_id")
            
            try manageContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func delete(reviewId: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: reviewEntityName)
        fetchRequest.predicate = NSPredicate(format: "review_id = %d", reviewId)
        
        do {
            let fetch = try manageContext.fetch(fetchRequest)
            let delete = fetch[0] as! NSManagedObject
            manageContext.delete(delete)
            try manageContext.save()
        } catch let error {
            print(error)
        }
    }
}
