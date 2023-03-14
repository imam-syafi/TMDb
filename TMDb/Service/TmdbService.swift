//
//  TmdbService.swift
//  TMDb
//
//  Created by imsyf on 3/10/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit
import Alamofire

protocol TmdbServiceDelegate {
    func onGetMoviesSucceed(movies: [Movie])
    func onGetMoviesFailed()
}

class TmdbService: NSObject {
    
    static let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"
    
    var delegate: TmdbServiceDelegate?
    
    func getTopRatedMovies() {
        let url = createEndpoint(path: "/movie/top_rated")
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                if response.result.isSuccess {
                    let data = try! JSONDecoder().decode(GetMoviesResponse.self, from: response.data!)
                    self.delegate?.onGetMoviesSucceed(movies: data.results)
                } else {
                    self.delegate?.onGetMoviesFailed()
                }
        }
    }
    
    func searchMovies(query: String) {
        let url = createEndpoint(
            path: "/search/movie",
            queryItems: [
                URLQueryItem(name: "query", value: query)
            ]
        )
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                if response.result.isSuccess {
                    let data = try! JSONDecoder().decode(GetMoviesResponse.self, from: response.data!)
                    self.delegate?.onGetMoviesSucceed(movies: data.results)
                } else {
                    self.delegate?.onGetMoviesFailed()
                }
        }
    }
    
    private func createEndpoint(path: String, queryItems: [URLQueryItem] = []) -> URL {
        var components = URLComponents(string: "https://api.themoviedb.org/3")
        
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "2a35719cd2c1e31362c38eeda7f0e117"),
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components?.queryItems?.append(contentsOf: queryItems)
        
        return components!.url!.appendingPathComponent(path)
    }
}

