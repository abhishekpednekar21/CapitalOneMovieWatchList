//
//  MovieListPresenter.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import Combine
import UIKit


protocol MovieListPresenterProtocol {
    
    var listPublisher: AnyPublisher<Void, Never> { get }
    func initial()
    func getMovies() -> [Movies]
    func getMoviesCount() -> Int
    func getCurrentMovie(at index:Int) -> Movies
    func isMovieInWatchList(movieID: String) -> Bool
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    var listPublisher: AnyPublisher<Void, Never>
    private var updateListPublisher = PassthroughSubject<Void, Never>()
    private let movieListInteractor:MovieListInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published private var movies : [Movies] = []
    
    required init(interactor:MovieListInteractorProtocol){
        self.movieListInteractor = interactor
        listPublisher = updateListPublisher.eraseToAnyPublisher()
    }
    
    func initial() {
        movieListInteractor.movieList().sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] in
            self?.updateMovieList(movies: $0 ?? [])
            MovieRepository().set(records: $0 ?? [])
        })
        .store(in: &cancellables)
    }
    
    func getMoviesCount() -> Int {
        return self.movies.count
    }
    
    func getMovies() -> [Movies] {
        return self.movies
    }
    
    func isMovieInWatchList(movieID: String) -> Bool{
        let watchListRepository = WatchListRepository()
        if watchListRepository.getWatchList().movieIdArr.count > 0 {
            if watchListRepository.getWatchList().movieIdArr.contains(movieID){
                return true
            }
        }
        return false
    }
    
    private func updateMovieList(movies: [Movies]) {
        self.movies = movies
        updateListPublisher.send()
    }
    
    func getCurrentMovie(at index:Int) -> Movies {
        return self.movies[index]
    }
}
