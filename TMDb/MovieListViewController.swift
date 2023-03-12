//
//  SearchResultViewController.swift
//  TMDb
//
//  Created by imsyf on 3/8/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieListTable: UITableView!
    
    let cellIdentifier = "MovieCell"
    let tmdbService = TmdbService()
    
    var query: String?
    var topRatedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }
    
    func setupUI() {
        movieListTable.delegate = self
        movieListTable.dataSource = self
        movieListTable.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func loadData() {
        tmdbService.delegate = self
        
        if query != nil {
            tmdbService.searchMovies(query: query!)
        } else {
            tmdbService.getTopRatedMovies()
        }
    }
}

extension MovieListViewController : TmdbServiceDelegate {
    func onGetMoviesSucceed(movies: [Movie]) {
        topRatedMovies.append(contentsOf: movies)
        movieListTable.reloadData()
    }

    func onGetMoviesFailed() {
        self.presentAlert(message: "Failed to fetch remote data")
    }
}

extension MovieListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        let data = topRatedMovies[indexPath.row]
        
        cell.posterImageView.loadFromUrl(url: TmdbService.BASE_IMG_URL + data.getPosterPath())
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "Rating: \(data.vote_average)"
        cell.overviewLabel.text = data.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = topRatedMovies[indexPath.row]
        let detailController = DetailViewController()

        detailController.movieDto = data
        detailController.title = "Movie Detail"
        detailController.modalPresentationStyle = .fullScreen

        let backItem = UIBarButtonItem()
        backItem.title = "Back"

        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
