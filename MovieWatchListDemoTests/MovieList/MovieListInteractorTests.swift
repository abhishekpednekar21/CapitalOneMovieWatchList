//
//  MovieListInteractorTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MovieListInteractorTests: XCTestCase {
    
    var mockAPIService: MockAPIService!
    var interactor: MockMovieListInteractor!
    var cancellable: AnyCancellable!

    override func setUpWithError() throws {
        mockAPIService = MockAPIService()
        interactor = MockMovieListInteractor()
    }

    override func tearDownWithError() throws {
        mockAPIService = nil
        interactor = nil
        cancellable = nil
    }
    
    func testMovieListInteractor_InitializedToFetchMovies() {
        _ = interactor.movieList()
        XCTAssertTrue(interactor.isMovieListCalled, "Error")
    }
    
    func testMovieListInteractor_CalledToReturnMovies() {
        let publisher = interactor.movieList()
        _ = publisher.sink { movies in
            print(movies?.count as Any)
        }
        
        XCTAssertNotNil(publisher)
    }
}
