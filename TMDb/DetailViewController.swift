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
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var commentSectionLabel: UILabel!
    
    var obs: NSKeyValueObservation?
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let storage = ReviewStorage()
    let reviewCellIdentifier = "ReviewCell"
    var reviewsData = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        obs = reviewTableView.observe(\.contentSize, options: .new) { (_, change) in
            guard let height = change.newValue?.height else { return }
            self.heightConstraint.constant = height
        }
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviewData()
    }
    
    func setupReviewTableUI() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: reviewCellIdentifier, bundle: nil), forCellReuseIdentifier: reviewCellIdentifier)
    }
    
    func loadReviewData() {
        if let movieId = movieDto?.id {
            reviewsData = storage.getByMovieId(movieId: movieId)
            
            reviewTableView.reloadData()
            
            emptyLabel.isHidden = !reviewsData.isEmpty
            commentSectionLabel.text = reviewsData.isEmpty ? "Comment Section" : "Comment Section (\(reviewsData.count))"
        }
    }
    
    @IBAction func writeRevieBtnTapped(_ sender: UIButton) {
        self.navigateToComment()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = reviewsData[indexPath.row]
        self.navigateToComment(review: data)
    }
}

extension DetailViewController {
    
    func navigateToComment(review: Review? = nil) {
        let controller = CommentViewController()
        
        controller.review = review
        controller.movieId = self.movieDto?.id
        controller.title = review != nil ? "Edit Comment" : "Add Comment"
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
