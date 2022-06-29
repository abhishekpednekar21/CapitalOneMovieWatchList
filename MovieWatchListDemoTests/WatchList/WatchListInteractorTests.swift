//
//  WatchListInteractorTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class WatchListInteractorTests: XCTestCase {
    
    var interactor: MockWatchListInteractor!
    var cancellable: AnyCancellable!

    override func setUpWithError() throws {
        interactor = MockWatchListInteractor()
    }

    override func tearDownWithError() throws {
        interactor = nil
        cancellable = nil
    }
    
    func testWatchListInteractor_WhenInitiliazed() {
        _ = interactor.watchList()
        XCTAssertTrue(interactor.isWatchListCalled, "")
    }
    
    func testWatchListnteractor_WhenCalled_ReturnsWatchListMovies() {
        let publisher = interactor.watchList()
        _ = publisher.sink { movie in
            print(movie.count)
        }
        XCTAssertNotNil(publisher)
    }
}
