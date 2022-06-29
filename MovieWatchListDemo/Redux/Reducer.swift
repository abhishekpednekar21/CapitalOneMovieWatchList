//
//  Reducer.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-26.
//

import Foundation

class Reducer {
    func updateWatchList(state: inout AppState, action: AppAction) {
        
        switch action {
        
        // add Movies
        case .add:
            let repo = WatchListRepository()
            let watchList = repo.getWatchList()
            watchList.add(id: state.id)
            state.watchList = watchList
        
        // remove Movies
        case .remove:
            let repo = WatchListRepository()
            let watchList = repo.getWatchList()
            watchList.remove(id: state.id)
            state.watchList = watchList
        }
    }
}
