//
//  DetailViewController.swift
//  TMDb
//
//  Created by Imamsyf on 3/7/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var movieDto: Movie?

    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        if movieDto != nil {
            backdrop.loadFromUrl(url: TmdbService.BASE_IMG_URL + movieDto!.getBackdropPath())
            poster.loadFromUrl(url: TmdbService.BASE_IMG_URL + movieDto!.getPosterPath())
            titleLabel.text = movieDto!.title
            releaseLabel.text = movieDto!.release_date
            ratingLabel.text = "⭐ \(movieDto!.vote_average)"
            overviewLabel.text = movieDto!
                .overview
        }
    }
}
