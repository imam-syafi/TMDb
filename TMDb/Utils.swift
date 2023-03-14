//
//  Utils.swift
//  TMDb
//
//  Created by imsyf on 3/10/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String = "Warning", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    
    func loadFromUrl(url: String) {
        if let urls = URL(string: url) {
            let task = URLSession.shared.dataTask(with: urls) { data, response, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }

            task.resume()
        }
    }
}

extension String {

    var alphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
}
