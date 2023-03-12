//
//  ProfileViewController.swift
//  TMDb
//
//  Created by imsyf on 3/9/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var people: People?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var knownForLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if people != nil {
            imageView.image = UIImage(named: people!.photo)
            nameLabel.text = people!.name
            knownForLabel.text = people!.knownForDepartment
            popularityLabel.text = "⭐ \(people!.popularity)"
        }
    }
}
