//
//  MockWatchListInteractor.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockWatchListInteractor: WatchListInteractorProtocol {
    
    var isWatchListCalled: Bool = false
    var movieList: [Movies]?
    
    func watchList() -> AnyPublisher<[Movies], Never> {
        isWatchListCalled = true
        let movie = Movies.defaultMovie
        
        movieList = [movie]
        return Just(movieList!).eraseToAnyPublisher()
    }
}
