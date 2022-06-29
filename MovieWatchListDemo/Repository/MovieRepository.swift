//
//  MovieRepository.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-28.
//

import Foundation


class MovieRepository: NSObject, Repository {
    typealias T = Movies
    static var storageKey: String { String(describing: MovieRepository.self) }
    
    func get(id: String) -> Movies? {
        
        getAll().filter({$0.id == id}).first
    }
    
    
    func set(record: Movies) {
        var movies = getAll().filter({$0.id != record.id})
        movies.append(record)
        set(records: movies)
    }
    
    func set(records: [Movies]) {
        guard let encodedData = try? PropertyListEncoder().encode(records) else {
                return
            }
        UserDefaults.standard.set(encodedData, forKey: MovieRepository.storageKey)
    }

}
