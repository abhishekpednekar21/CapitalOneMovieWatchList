//
//  WatchListPresenter.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import Combine

protocol WatchListPresenterProtocol {
    var watchListPublisher: AnyPublisher<Void, Never> { get }
    func getWatchListMovies() -> [Movies]
    func initial()
    func updateMovieList()
    func moviesCount() -> Int
    func getCurrentMovie(at index:Int) -> Movies
}

class WatchListPresenter: WatchListPresenterProtocol {
       
    //MARK: - Variables
    var watchListPublisher: AnyPublisher<Void, Never>
    private var updateWatchListPublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let interactor: WatchListInteractorProtocol
    var movies: [Movies] = []
    
    //MARK: - Initializer
    init(interactor: WatchListInteractorProtocol) {
        self.interactor = interactor
        watchListPublisher = updateWatchListPublisher.eraseToAnyPublisher()
    }
    
    //MARK: - Methods

    func initial() {
        interactor.watchList().sink { _ in
        } receiveValue: { [weak self] in
            self?.addMovies(movies: $0)
        }
        .store(in: &cancellables)
    }

    
    func getWatchListMovies() -> [Movies] {
        return movies
    }
    
    func moviesCount() -> Int {
        return self.movies.count
    }
    
    func addMovies(movies: [Movies]){
        self.movies = movies
        updateWatchListPublisher.send()
    }
    
    func updateMovieList() {
        initial()
        self.movies = getWatchListMovies()
        updateWatchListPublisher.send()
    }

    func getCurrentMovie(at index:Int) -> Movies {
        if self.movies.count > index{
            return self.movies[index]
        }
        return Movies.emptyMovie
    }
}
