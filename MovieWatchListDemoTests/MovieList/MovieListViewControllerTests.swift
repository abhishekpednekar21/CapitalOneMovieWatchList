//
//  MovieListViewControllerTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
@testable import MovieWatchListDemo

class MovieListViewControllerTests: XCTestCase {

    var viewControllerUnderTest: MovieListViewController!
    var presenter: MockMovieListPresenter!
    
    override func setUpWithError() throws {
        
        presenter = MockMovieListPresenter()
        presenter.initial()
        self.viewControllerUnderTest = MovieListViewController(with: presenter)
        
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    
        presenter.movieList = [Movies.defaultMovie]
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.movieListView.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.movieListView.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.movieListView.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
}
