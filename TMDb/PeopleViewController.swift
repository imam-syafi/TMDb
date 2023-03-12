//
//  PeopleViewController.swift
//  TMDb
//
//  Created by imsyf on 3/9/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    var peopleList = [People]()
    let cellIdentifier = "PeopleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        setupUI()
        loadData()
    }
    
    func setupUI() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(
            UINib(nibName: cellIdentifier, bundle: nil),
            forCellWithReuseIdentifier: cellIdentifier
        )
    }

    func loadData() {
        peopleList.append(contentsOf: People.SAMPLES)
        peopleCollectionView.reloadData()
    }
}

extension PeopleViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PeopleCell
        let data = peopleList[indexPath.row]
        
        cell.imageView.image = UIImage(named: data.photo)
        cell.nameLabel.text = data.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let data = peopleList[indexPath.row]
        let controller = ProfileViewController()
        
        controller.people = data
        controller.title = "People Detail"
        controller.modalPresentationStyle = .fullScreen
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
