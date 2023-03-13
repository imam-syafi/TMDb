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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Please fill in your name…",
            attributes: [
                NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ]
        )
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
            self.presentAlert(title: "Info", message: "Ready to be submitted")

            print(name)
            print(comment)
            
//            self.navigationController?.popViewController(animated: true)
        }
    }
}
