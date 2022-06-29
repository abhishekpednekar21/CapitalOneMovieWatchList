//
//  MockWatchListPresenter.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockWatchListPresenter: WatchListPresenterProtocol {
  
    var watchListPublisher: AnyPublisher<Void, Never> = Result.Publisher(()).eraseToAnyPublisher()
    var movies: [Movies] = []
    var isWatchListCalled : Bool = false
    var cancellables : AnyCancellable?
    private var updateWatchListPub = PassthroughSubject<Void, Never>()
    
    func getWatchListMovies() -> [Movies] {
        return movies
    }
    
    func initial() {
        isWatchListCalled = true
        cancellables = watchListPublisher.sink(receiveValue: { _ in
            print("WatchList Recieved")
        })
    }
    
    func updateMovieList() {
        initial()
        movies = getWatchListMovies()
        updateWatchListPub.send()
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
    
    func getCurrentMovie(at index: Int) -> Movies {
        return movies[index]
    }
}
