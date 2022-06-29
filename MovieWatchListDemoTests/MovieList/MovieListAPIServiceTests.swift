//
//  MockAPIServiceTests.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo


class MockAPIServiceTests: XCTestCase {

    private var serviceClientMock: MockServiceClient!
    private var apiService: APIServiceProtocol!
    private var expectation: XCTestExpectation!
    private var cancellable: AnyCancellable!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceClientMock = MockServiceClient()
        apiService  = APIService(serviceClient: serviceClientMock)
        expectation = expectation(description: "wait for publisher")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceClientMock = nil
        apiService = nil
        cancellable = nil
        expectation = nil
    }
    
    private func expectationWait() {
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchMoviesList_WithValidURL_RecievesMovies(){
        
        let movie = Movies(id: "tt0111161", title: "The Shawshank Redemption", year: "1997",  image: "ImageUrl", imDbRating : "9.2", crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman")
        
        serviceClientMock.result = MovieList(items: [movie])
        
        let expectedResult = [movie]
        
        var actualResult : [Movies]?
        cancellable =  apiService.fetchMoviesList(fromUrl: Endpoint.movieURL())
            .sink{ _ in} receiveValue: { movies in
                actualResult = movies
                self.expectation.fulfill()
            }
        
        expectationWait()
        
        XCTAssertEqual(expectedResult,actualResult,"Error")
        
    }
    
    func testFecthMoviesList_WithValidURL_ReturnEmptyArray(){
        
        let movie = Movies(id: "tt0111161", title: "The Shawshank Redemption", year: "1997",  image: "ImageUrl", imDbRating : "9.2", crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman")
        
        serviceClientMock.result = MovieList(items: [])
        
        let expectedResult = [movie]
        
        var actualResult : [Movies]?
        cancellable =  apiService.fetchMoviesList(fromUrl: Endpoint.movieURL())
            .sink{ _ in} receiveValue: { movies in
                actualResult = movies
                self.expectation.fulfill()
            }
        expectationWait()
        
        XCTAssertNotEqual(expectedResult,actualResult,"Error")
    }
    
    func testFecthMoviesList_WithValidURL_ReturnInvalidResponse(){
      
        let movie = Movies(id: "tt0111161", title: "The Shawshank Redemption", year: "1997",  image: "ImageUrl", imDbRating : "9.2", crew: "Frank Darabont (dir.), Tim Robbins, Morgan Freeman")
        
        serviceClientMock.result = [movie]
        
        let expectedResult = [movie]
        
        var actualResult : [Movies]?
        
        cancellable =  apiService.fetchMoviesList(fromUrl: Endpoint.movieURL())
            .sink{ _ in} receiveValue: { movies in
                actualResult = movies
                self.expectation.fulfill()
            }
        expectationWait()
        
        XCTAssertNotEqual(expectedResult,actualResult,"Error")
    }
    
}
