//
//  MovieListPresenterTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MovieListPresenterTests: XCTestCase {

    var interactor: MockMovieListInteractor!
    var presenter: MockMovieListPresenter!
    private var expectation: XCTestExpectation!
    private var cancellable: AnyCancellable!

    override func setUpWithError() throws {
        interactor = MockMovieListInteractor()
        presenter = MockMovieListPresenter()
        expectation = expectation(description: "wait for publisher")
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        expectation = nil
    }

    private func expectationWait() {
        wait(for: [expectation], timeout: 10)
    }
    
    func testMovieListPresenter_initiated_MoviesListCalled() {
        var movieListUpdated = false
        
        cancellable = presenter.listPublisher .sink {
            movieListUpdated = true
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        XCTAssertTrue(movieListUpdated, "")
    }
    
    func testMovieListPresenter_initiated_ReturnsMovies() {
        
        presenter.movieList = [Movies.emptyMovie]
        
        cancellable = presenter.listPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        
        expectationWait()
        XCTAssertNotNil(presenter.getMovies, "")
    }
    
    func testMovieListPresenter_initiated_ReturnsData() {
        
        presenter.movieList = [Movies.emptyMovie]
        cancellable = presenter.listPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        XCTAssertEqual(presenter.getMoviesCount(), 1,"")
    }
    
    func testMovieListPresenter_initiated_ReturnGivenIndex() {
        
        let movie = Movies.emptyMovie
        presenter.movieList = [movie]
        cancellable = presenter.listPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        XCTAssertEqual(presenter.getCurrentMovie(at: 0), movie,"")
    }
    
    func testMovieListPresenter_initiateMovieListCalled_IfMovieinWatchList_ReturnTrue() {
        
        let movie = Movies.defaultMovie
        presenter.movieList = [movie]
        cancellable = presenter.listPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        MovieRepository().set(records: presenter.movieList)
        let isMovieAvailable = presenter.isMovieInWatchList(movieID: movie.id)
        
        expectationWait()
        
        XCTAssertTrue(isMovieAvailable,"")
    }
    
    func testMovieListPresenter_initiated_IfMovieinWatchList_ReturnFalse() {
        
        let movie = Movies.defaultMovie
        presenter.movieList = [movie]
        cancellable = presenter.listPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        MovieRepository().set(records: presenter.movieList)
        let isMovietAvailable = presenter.isMovieInWatchList(movieID: "")
        
        expectationWait()
        
        XCTAssertFalse(isMovietAvailable,"")
    }

}
