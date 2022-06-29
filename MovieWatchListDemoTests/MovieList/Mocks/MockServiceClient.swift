//
//  MockServiceClient.swift
//  MovieWatchListDemoTests
//
//  Created by Abdul Rahman on 2022-06-29.
//

import XCTest
import Combine
@testable import MovieWatchListDemo

class MockServiceClient: ServiceClientProtocol {
    
    var result: Decodable?
    
    func getData<T>(fromUrl: URL, type: T.Type) -> AnyPublisher<T?, Never> where T : Decodable {
        
        return Just(result as? T)
            .eraseToAnyPublisher()
    }
}
