//
//  ServiceClient.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-27.
//

import Foundation
import Combine

protocol ServiceClientProtocol {
    func getData<T: Decodable>(fromUrl: URL, type:T.Type) -> AnyPublisher<T?,Never>
}

class ServiceClient: ServiceClientProtocol{
    
    func getData<T: Decodable>(fromUrl: URL, type:T.Type) -> AnyPublisher<T?,Never>{
        return URLSession.shared.dataTaskPublisher(for: fromUrl)
            .map{$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .map{$0}
            .assertNoFailure()
            .receive(on: RunLoop.main, options: nil)
            .eraseToAnyPublisher()
    }
}
