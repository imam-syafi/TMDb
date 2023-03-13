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
    
    var review: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            // TODO: Core Data
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
