//
//  MockMovieListPresenter.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockMovieListPresenter: MovieListPresenterProtocol {
   
    var listPublisher: AnyPublisher<Void, Never> = Result.Publisher(()).eraseToAnyPublisher()
    var cancellables: AnyCancellable?
    
    var isInitialCalled: Bool = false
    var movieList: [Movies] = []
    
    func initial() {
        isInitialCalled = true
        cancellables = listPublisher.sink(receiveValue: { _ in
            print("Test")
        })
    }
    
    func getMovies() -> [Movies] {
        return movieList
    }
    
    func getMoviesCount() -> Int {
        return movieList.count
    }
    
    func getCurrentMovie(at index: Int) -> Movies {
        return movieList[index]
    }
    
    func isMovieInWatchList(movieID: String) -> Bool {
        if movieID == "tt0111161" {
            return true
        }
        return false
    }
}
