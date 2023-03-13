//
//  IconMenuCell.swift
//  TMDb
//
//  Created by imsyf on 3/12/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

class IconMenuCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    var action: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 10
    }

    @IBAction func btnTapped(_ sender: UIButton) {
        action?()
    }
}
