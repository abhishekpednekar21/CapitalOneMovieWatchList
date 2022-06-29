//
//  APIService.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-27.
//

import Foundation
import Combine

protocol APIServiceProtocol{
    func fetchMoviesList(fromUrl: URL)->AnyPublisher<[Movies]?, Never>
}

class APIService : APIServiceProtocol {
    
    private let serviceClient : ServiceClientProtocol
    
    init(serviceClient: ServiceClientProtocol = ServiceClient()){
        self.serviceClient = serviceClient
    }
     // Fetch Movies using ServiceClient & URL - EndPoint 
    func fetchMoviesList(fromUrl: URL) -> AnyPublisher<[Movies]?, Never> {
        
        return serviceClient.getData(fromUrl: fromUrl, type: MovieList.self)
            .map{$0?.items}
            .receive(on: RunLoop.main, options: nil)
            .eraseToAnyPublisher()
    }
    
    
}

