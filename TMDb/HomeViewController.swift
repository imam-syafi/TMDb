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
    
    @IBOutlet weak var iconMenuCollection: UICollectionView!
    @IBOutlet weak var gridHeight: NSLayoutConstraint!
    
    let headerIdentifier = "HeaderView"
    let cellIdentifier = "IconMenuCell"
    var iconMenuDataSource = [IconMenu]()
    var sectionMenuData = [SectionMenu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewCollection: [UIView] = [
            searchField,
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
        
        iconMenuCollection.delegate = self
        iconMenuCollection.dataSource = self
        iconMenuCollection.register(
            UINib(nibName: headerIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: headerIdentifier
        )
        iconMenuCollection.register(
            UINib(nibName: cellIdentifier, bundle: nil),
            forCellWithReuseIdentifier: cellIdentifier
        )
        
        loadIconMenuData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Workaround
        gridHeight.constant = iconMenuCollection.collectionViewLayout.collectionViewContentSize.height
        view.layoutIfNeeded()
    }
    
    func loadIconMenuData() {
        sectionMenuData = [
            SectionMenu(
                header: "Movies",
                iconMenus: [
                    IconMenu(icon: "icons8-imovie-50", title: "Top Rated", action: topRatedMovieTapped),
                    IconMenu(icon: "icons8-movie-projector-50", title: "Upcoming", action: todo),
                    IconMenu(icon: "icons8-movie-theater-64", title: "Now Playing", action: todo),
                    IconMenu(icon: "icons8-movie-ticket-50", title: "Popular", action: todo),
                ]
            ),
            SectionMenu(
                header: "TV Shows",
                iconMenus: [
                    IconMenu(icon: "icons8-retro-tv-filled-50", title: "Popular", action: todo),
                    IconMenu(icon: "icons8-popcorn-64", title: "Top Rated", action: todo),
                    IconMenu(icon: "icons8-clapperboard-50", title: "On the Air", action: todo),
                    IconMenu(icon: "icons8-cinema-50", title: "Airing Today", action: todo),
                ]
            ),
            SectionMenu(
                header: "People",
                iconMenus: [
                    IconMenu(icon: "icons8-charlie-chaplin-64", title: "Popular", action: popularPeopleTapped),
                ]
            )
        ]
        
        iconMenuCollection.reloadData()
    }
    
    func todo() {
        self.presentAlert(title: "Info", message: "Coming Soon")
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
    
    func topRatedMovieTapped() {
        let controller = MovieListViewController()
        
        controller.title = "Top Rated Movies"
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popularPeopleTapped() {
        let controller = PeopleViewController()
        
        controller.title = "Popular People"
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionMenuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionMenuData[section].iconMenus.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        print("Foo header")
//        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderView
    
//        HeaderCell.titleLabel
        
//        return headerCell
    
//        return UICollectionReusableView()
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! IconMenuCell
        let data = sectionMenuData[indexPath.section].iconMenus[indexPath.row]

        cell.iconImg.image = UIImage(named: data.icon)
        cell.btn.setTitle(data.title, for: .normal)
        cell.action = data.action

        return cell
    }
}
