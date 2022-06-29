//
//  WatchListInteractor.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import Combine

protocol WatchListInteractorProtocol{
    func watchList() -> AnyPublisher<[Movies], Never>
}

class WatchListInteractor:WatchListInteractorProtocol {
    
    //MARK: - Variables
    let repository: WatchListRepository

    //MARK: - Initializer
    init (repository: WatchListRepository) {
      self.repository = repository
    }
    
    //MARK: - Methods
    func watchList() -> AnyPublisher<[Movies], Never>{
        return self.repository.getAllMoviesInWatchList()
            .receive(on: RunLoop.main,options: nil)
          .eraseToAnyPublisher()
    }
}
