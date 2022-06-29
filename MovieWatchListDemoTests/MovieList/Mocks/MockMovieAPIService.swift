//
//  MockAPIService.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockAPIService: APIServiceProtocol {
    
    var isFetchMoviesLitsCalled : Bool = false
    var moviesList : [Movies]?
    
    func fetchMoviesList(fromUrl: URL) -> AnyPublisher<[Movies]?, Never> {
       
        return Just(moviesList)
            .eraseToAnyPublisher()
    }
    

}
