//
//  WatchListPresenterTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class WatchListPresenterTests: XCTestCase {

    var interactor: MockWatchListInteractor!
    var presenter: MockWatchListPresenter!
    private var expectation: XCTestExpectation!
    private var cancellable: AnyCancellable!
    
    override func setUpWithError() throws {
        interactor =  MockWatchListInteractor()
        presenter = MockWatchListPresenter()
        expectation = expectation(description: "wait")
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        expectation = nil
    }
    
    private func expectationWait() {
        wait(for: [expectation], timeout: 10)
    }
    
    func test_Initiated() {
        
        var iswatchListListUpdated = false
        cancellable = presenter.watchListPublisher.sink {
            iswatchListListUpdated = true
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        
        XCTAssertTrue(iswatchListListUpdated, "")
    }
    
    func test_Initiated_ReturnsMovies() {
        
        presenter.movies = [Movies.defaultMovie]
        
        cancellable = presenter.watchListPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        XCTAssertNotNil(presenter.getWatchListMovies, "")
    }
    
    func test_Initiated_ReturnsNonZeroCount() {
        
        presenter.movies = [Movies.defaultMovie]
        cancellable = presenter.watchListPublisher.sink {
            self.expectation.fulfill()
        }
        
        presenter.initial()
        
        expectationWait()
        XCTAssertEqual(presenter.moviesCount(), 1,"")
    }
}
