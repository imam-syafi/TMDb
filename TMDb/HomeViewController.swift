//
//  HomeViewController.swift
//  TMDb
//
//  Created by imsyf on 3/8/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var movieTopRatedBtn: UIButton!
    @IBOutlet weak var movieUpcomingBtn: UIButton!
    @IBOutlet weak var movieNowPlayingBtn: UIButton!
    @IBOutlet weak var moviePopularBtn: UIButton!
    
    @IBOutlet weak var tvPopularBtn: UIButton!
    @IBOutlet weak var tvTopRatedBtn: UIButton!
    @IBOutlet weak var tvOnAirBtn: UIButton!
    @IBOutlet weak var tvAiringTodayBtn: UIButton!
    
    @IBOutlet weak var peoplePopularBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewCollection: [UIView] = [
            searchField,
            movieTopRatedBtn,
            movieUpcomingBtn,
            movieNowPlayingBtn,
            moviePopularBtn,
            tvPopularBtn,
            tvTopRatedBtn,
            tvOnAirBtn,
            tvAiringTodayBtn,
            peoplePopularBtn
        ]

        // Do any additional setup after loading the view.
        for itemView in viewCollection {
            itemView.layer.borderWidth = 1
            itemView.layer.borderColor = UIColor.white.cgColor
            itemView.layer.cornerRadius = 10
        }
        
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Search a movie…",
            attributes: [
                NSAttributedStringKey.foregroundColor: UIColor.gray
            ]
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        let query = searchField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .alphanumeric ?? ""
        
        if query.isEmpty {
            self.presentAlert(message: "Please fill in movie title")
        } else {
            let controller = MovieListViewController()
            
            controller.query = query
            controller.title = "Search Result for: \(query)"
            controller.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func topRatedMovieTapped(_ sender: UIButton) {
        let controller = MovieListViewController()
        
        controller.title = "Top Rated Movies"
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func iconBtnTapped(_ sender: UIButton) {
        self.presentAlert(title: "Info", message: "Coming Soon")
    }
    
    @IBAction func popularPeopleTapped(_ sender: UIButton) {
        let controller = PeopleViewController()
        
        controller.title = "Popular People"
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
