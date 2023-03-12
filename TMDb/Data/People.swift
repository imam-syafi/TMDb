//
//  People.swift
//  TMDb
//
//  Created by imsyf on 3/9/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

struct People {
    var id: Int
    var name: String
    var gender: Int
    var photo: String
    var knownForDepartment: String
    var popularity: Double
}

#if DEBUG
    extension People {
        static let SAMPLES = [
            People(
                id: 1136406,
                name: "Tom Holland",
                gender: 2,
                photo: "tomholland",
                knownForDepartment: "Acting",
                popularity: 127.956
            ),
            People(
                id: 1972974,
                name: "Isabel May",
                gender: 1,
                photo: "isabelmay",
                knownForDepartment: "Acting",
                popularity: 57.407
            ),
            People(
                id: 1215399,
                name: "Taylor Sheridan",
                gender: 2,
                photo: "taylorsheridan",
                knownForDepartment: "Writing",
                popularity: 72.778
            ),
            People(
                id: 2280178,
                name: "Sofia Kappel",
                gender: 1,
                photo: "sofiakappel",
                knownForDepartment: "Acting",
                popularity: 69.485
            ),
            People(
                id: 115440,
                name: "Sydney Sweeney",
                gender: 1,
                photo: "sydneysweeney",
                knownForDepartment: "Acting",
                popularity: 66.157
            ),
            People(
                id: 976,
                name: "Jason Statham",
                gender: 2,
                photo: "jasonstatham",
                knownForDepartment: "Acting",
                popularity: 62.457
            ),
            People(
                id: 1318650,
                name: "Willa Fitzgerald",
                gender: 1,
                photo: "willafitzgerald",
                knownForDepartment: "Acting",
                popularity: 62.068
            ),
            People(
                id: 6614,
                name: "Cole Hauser",
                gender: 2,
                photo: "colehauser",
                knownForDepartment: "Acting",
                popularity: 60.926
            ),
            
        ]
    }
#endif
