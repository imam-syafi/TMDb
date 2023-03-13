//
//  Review.swift
//  TMDb
//
//  Created by imsyf on 3/13/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

struct Review {
    var name: String
    var comment: String
}

extension Review {
    static let SAMPLES = [
        Review(name: "John Doe", comment: "Very good movie with good actor and actress, it had so many beautiful place in this movie, I cried a lot when watch this."),
        Review(name: "Name", comment: "Comment"),
        Review(name: "Some Dude", comment: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in."),
    ]
}
