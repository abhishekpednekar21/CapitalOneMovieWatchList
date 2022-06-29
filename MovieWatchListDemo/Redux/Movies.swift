//
//  Movies.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-27.
//

import Foundation

struct MovieList: Codable {
    let items: [Movies]
}

struct Movies : Codable, Equatable {
    let id : String
    let title : String
    let year: String
    let image: String?
    let imDbRating : String
    let crew: String
    
    static var emptyMovie: Movies {
        Movies(id: "", title: "", year: "",  image: "", imDbRating : "", crew: "")
    }
    
    static var defaultMovie: Movies {
        Movies(id: "tt0111161", title: "The Shawshank Redemption", year: "1997",  image: "ImageUrl", imDbRating : "9.2", crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman")
    }
}


