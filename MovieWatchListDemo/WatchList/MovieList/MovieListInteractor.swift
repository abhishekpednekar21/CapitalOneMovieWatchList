//
//  MovieListInteractor.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import Combine


protocol MovieListInteractorProtocol{
    func movieList() -> AnyPublisher<[Movies]?, Never>
}


class MovieListInteractor:MovieListInteractorProtocol{

    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol){
        self.apiService = apiService
    }

    func movieList() -> AnyPublisher<[Movies]?, Never> {
        apiService.fetchMoviesList(fromUrl: Endpoint.movieURL())
            .receive(on: RunLoop.main, options: nil)
            .eraseToAnyPublisher()
    }
    
}
