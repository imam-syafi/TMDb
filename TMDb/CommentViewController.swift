//
//  CommentViewController.swift
//  TMDb
//
//  Created by imsyf on 3/13/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var review: Review?
    var movieId: Int?
    let storage = ReviewStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        deleteBtn.isHidden = review?.id == nil
        
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Please fill in your name…",
            attributes: [
                NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ]
        )
        
        if review != nil {
            nameField.text = review?.name
            commentField.text = review?.comment
            submitBtn.setTitle("Update", for: .normal)
        }
    }
    
    
    @IBAction func onDelete(_ sender: UIButton) {
        if let reviewId = review?.id {
            storage.delete(reviewId: reviewId)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        let name = nameField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let comment = commentField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if name.isEmpty {
            self.presentAlert(message: "Please fill in your name")
        } else if comment.isEmpty {
            self.presentAlert(message: "Please fill in your comment")
        } else {
            if review?.id != nil {
                
            } else {
                var reviewId = 1
                
                if let number = UserDefaults.standard.value(forKey: "LAST_SAVED_REVIEW_ID") as? Int {
                    reviewId = number + 1
                }
                
                let insert = Review(
                    id: reviewId,
                    name: name,
                    comment: comment,
                    movieId: movieId
                )
                
                storage.save(review: insert)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
