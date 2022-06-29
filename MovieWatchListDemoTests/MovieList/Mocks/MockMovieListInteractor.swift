//
//  MockMovieListInteractor.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockMovieListInteractor: MovieListInteractorProtocol {
    
    var isMovieListCalled: Bool = false
    var listofMovies: [Movies]?
    
    func movieList() -> AnyPublisher<[Movies]?, Never> {
        
        isMovieListCalled = true
        
        let movie = Movies(id: "tt0111161", title: "The Shawshank Redemption", year: "1997",  image: "ImageUrl", imDbRating : "9.2", crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman")
        
        listofMovies = [movie]
        
        return Just(listofMovies).eraseToAnyPublisher()
    }
    
    
}
