//
//  TopRatedResponse.swift
//  TMDb
//
//  Created by imsyf on 3/10/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

struct GetMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie : Codable {
    var id: Int
    var title: String
    var overview: String?
    var release_date: String?
    var backdrop_path: String?
    var poster_path: String?
    var popularity: Double
    var vote_average: Double
    var vote_count: Int
    
    func getPosterPath() -> String {
        return self.poster_path ?? ""
    }
    
    func getBackdropPath() -> String {
        return self.backdrop_path ?? ""
    }
}
