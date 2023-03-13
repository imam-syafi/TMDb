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
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let reviewCellIdentifier = "ReviewCell"
    var reviewsData = [Review]()
    
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
        
        setupReviewTableUI()
        loadReviewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Workaround to allow ScrollView recognize TableView's height
        heightConstraint.constant = reviewTableView.contentSize.height
        view.layoutIfNeeded()
    }
    
    func setupReviewTableUI() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: reviewCellIdentifier, bundle: nil), forCellReuseIdentifier: reviewCellIdentifier)
    }
    
    func loadReviewData() {
        reviewsData.append(contentsOf: Review.SAMPLES)
        reviewTableView.reloadData()
    }
    
    @IBAction func writeRevieBtnTapped(_ sender: UIButton) {
        
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellIdentifier, for: indexPath) as! ReviewCell
        let data = reviewsData[indexPath.row]
        
        cell.nameLabel.text = data.name
        cell.commentLabel.text = data.comment
        
        return cell
    }
}
