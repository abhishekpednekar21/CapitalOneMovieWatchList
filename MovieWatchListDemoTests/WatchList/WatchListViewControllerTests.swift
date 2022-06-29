//
//  WatchListViewControllerTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
@testable import MovieWatchListDemo

class WatchListViewControllerTests: XCTestCase {

    var viewControllerUnderTest: WatchListViewController!
    var presenter: MockWatchListPresenter!
    
    override func setUpWithError() throws {
        
        presenter = MockWatchListPresenter()
        presenter.initial()
        self.viewControllerUnderTest = WatchListViewController(with: presenter)
        
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    
        presenter.movies = [Movies.defaultMovie]
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.watchListView.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.watchListView.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.watchListView.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
}
