//
//  Endpoint.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-27.
//

import Foundation

class Endpoint{

    static func movieURL() -> URL{
        
        let apiKey = "k_8ptr39lt"
 
        guard let url = URL(string: "https://imdb-api.com/en/API/MostPopularMovies/\(apiKey)") else {
            fatalError("Invalid Url")
        }
        return url
    }
}
