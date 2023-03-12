//
//  TmdbService.swift
//  TMDb
//
//  Created by imsyf on 3/10/23.
//  Copyright © 2023 EDTS. All rights reserved.
//

import UIKit

protocol TmdbServiceDelegate {
    func onGetMoviesSucceed(movies: [Movie])
    func onGetMoviesFailed()
}

class TmdbService: NSObject {
    
    static let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"
    
    var delegate: TmdbServiceDelegate?
    
    func getTopRatedMovies() {
        var req = URLRequest(url: createEndpoint(path: "/movie/top_rated"))
        req.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: req) { body, res, err in
            let httpRes = res as! HTTPURLResponse
            
            if httpRes.statusCode == 200 {
                DispatchQueue.main.async {
                    let data = try! JSONDecoder().decode(GetMoviesResponse.self, from: body!)
                    self.delegate?.onGetMoviesSucceed(movies: data.results)
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.onGetMoviesFailed()
                }
            }
        }
        
        task.resume()
    }
    
    func searchMovies(query: String) {
        var req = URLRequest(
            url: createEndpoint(
                path: "/search/movie",
                queryItems: [
                    URLQueryItem(name: "query", value: query)
                ]
            )
        )
        req.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: req) { body, res, err in
            let httpRes = res as! HTTPURLResponse
            
            if httpRes.statusCode == 200 {
                DispatchQueue.main.async {
                    let data = try! JSONDecoder().decode(GetMoviesResponse.self, from: body!)
                    self.delegate?.onGetMoviesSucceed(movies: data.results)
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.onGetMoviesFailed()
                }
            }
        }
        
        task.resume()
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
