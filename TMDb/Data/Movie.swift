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

extension Movie {
    static let SAMPLE = Movie(
        id: 238,
        title: "The Godfather",
        overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
        release_date: "1972-03-14",
        backdrop_path: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
        poster_path: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
        popularity: 123.415,
        vote_average: 8.69,
        vote_count: 17586
    )
}
