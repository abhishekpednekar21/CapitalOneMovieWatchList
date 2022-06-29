//
//  WatchList.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-28.
//

import Foundation

class WatchList: NSObject, Codable {
    //MARK: - Variables
    var movieIdArr = [String]()
    
    //MARK: - Custom Methods
    func add(id: String) {
        guard !movieIdArr.contains(id) else {
            return
        }
        self.movieIdArr.append(id)
        WatchListRepository().set(record: self)
    }
    
    func remove(id: String) {
        self.movieIdArr = self.movieIdArr.filter({$0 != id})
        WatchListRepository().set(record: self)
    }
}
