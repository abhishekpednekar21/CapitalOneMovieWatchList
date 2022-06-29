//
//  Store.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-26.
//

import Foundation

class Store:ObservableObject {
    
    var reducer: Reducer
    @Published var appState: AppState?
    static let shared = Store(reducer: Reducer(), state: nil)

    func dispatch(action: AppAction, appState: inout AppState){
        reducer.updateWatchList(state: &appState, action: action)
    }
    init(reducer: Reducer, state: AppState?){
        self.reducer = reducer
        self.appState = state
    }
}
