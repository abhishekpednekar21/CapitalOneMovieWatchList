//
//  WatchListRepository.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-28.
//

import Foundation
import Combine

class WatchListRepository: NSObject, Repository {
  
    
    
    //MARK: - Variables
    typealias T = WatchList
    static var storageKey: String { String(describing: WatchListRepository.self) }
    static var storageForMoviesKey: String { String(describing: MovieRepository.self) }
    var movies: [Movies] = []
    
    //MARK: - Custom Methods
    func getAllMoviesInWatchList() -> AnyPublisher<[Movies], Never>{
        return Future<[Movies], Never> { promise in
            self.loadMovie{ movies in
                DispatchQueue.main.async {
                  promise(.success(movies))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func loadMovie(completion: @escaping ([Movies]) -> Void){
        DispatchQueue.global(qos: .background).async {
          let movies = self.loadSynchronously()
          completion(movies)
        }
    }

    private func loadSynchronously() -> [Movies] {
        var movieArray: [Movies] = [Movies]()
        let movieRepository = MovieRepository()
        for item in getWatchList().movieIdArr {
            movieArray.append(movieRepository.get(id: item) ?? Movies.emptyMovie)
        }
        print(movieArray)
        return movieArray
    }

    func get(id: String) -> WatchList? {
        getWatchList()
    }
    
    func getWatchList() -> WatchList {
        guard let watchList = getAll().first else {
            let newWatchList = WatchList()
            set(record: newWatchList)
            return newWatchList
        }
        return watchList
    }
    
    func set(record: WatchList) {
        let encodedRecord = try? PropertyListEncoder().encode(record)
        UserDefaults.standard.set([encodedRecord], forKey: WatchListRepository.storageKey)
    }
}
