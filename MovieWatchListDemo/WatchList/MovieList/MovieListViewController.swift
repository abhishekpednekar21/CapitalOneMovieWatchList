//
//  MovieListViewController.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import UIKit
import Combine

class MovieListViewController: UIViewController {

    private var webservice = APIService()
    private var cancellable : AnyCancellable?
    var movieListView =  MovieListView()
   
    var movieListPresenter: MovieListPresenterProtocol!
    private var cancellables = Set<AnyCancellable>()

    
    private var movieList = [Movies]() {
        didSet {
            self.movieListView.tableView.reloadData()
        }
    }
    
 
    init(with presenter: MovieListPresenterProtocol) {
        self.movieListPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Top 10 Popular Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
 
        self.view.addSubview(self.movieListView.tableView)
        setupTableView()
        sinkToPublishers()

        guard let presenter = self.movieListPresenter else {
            return
        }
        presenter.initial()
    }
 
    private func sinkToPublishers() {
        movieListPresenter?.listPublisher.sink {
            self.movieListView.tableView.reloadData()
        }.store(in: &cancellables)
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
 
   
    override func viewWillDisappear(_ animated: Bool) {
        
        let watchListViewController = WatchListViewController(with: WatchListPresenter(interactor: WatchListInteractor(repository: WatchListRepository())))
        
        watchListViewController.presetControlPassthroughSubject
            .sink{[weak self] movieId in
                self?.movieListView.tableView.reloadData()
            }
            .store(in: &self.cancellables)
    }
    
    
    private func setupTableView() {
        self.movieListView.tableView.delegate = self
        self.movieListView.tableView.dataSource = self
        self.movieListView.tableView.constrainToFillSuperview()
        self.movieListView.tableView.rowHeight = UITableView.automaticDimension
        self.movieListView.tableView.separatorColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}


extension MovieListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  self.movieListPresenter.getMoviesCount() > 10 {
            return 10
        }
         return self.movieListPresenter.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.movieListView.tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as? MovieListTableViewCell else {

            return UITableViewCell()
        }
        
        let movie = movieListPresenter.getCurrentMovie(at: indexPath.row)
        
        cell.nameLabel.text = movie.title
        cell.imdbScoreLabel.text = "Rating : \(movie.imDbRating)"
        cell.genreLabel.text = "Crew : \(movie.crew)"
        cell.yearLabel.text = "Year released : \(movie.year)"
        
        
        cell.thumbnailImage.loadImageUsingCacheWithUrlString(urlString: movie.image ?? "")

        cell.separatorInset = UIEdgeInsets.zero
        cell.addMovieButton.addTarget(self, action: #selector(checkoutButtonAction), for: .touchUpInside)
        cell.addMovieButton.isUserInteractionEnabled = true
        cell.addMovieButton.tag = indexPath.row

        if movieListPresenter.isMovieInWatchList(movieID: movie.id) {
            cell.addMovieButton.setTitleColor(.black, for: .normal)
            cell.addMovieButton.backgroundColor = .systemYellow
        }
        else {
            cell.addMovieButton.setTitleColor(.systemYellow, for: .normal)
            cell.addMovieButton.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateMovieSelection(movieSelected: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    //Add Movie to WatchList
    @objc func checkoutButtonAction(sender: UIButton!) {
        self.updateMovieSelection(movieSelected: sender.tag)
    }
        
    
    func updateMovieSelection(movieSelected : Int) {
        let selectedMovie = movieListPresenter.getCurrentMovie(at: movieSelected)
        let repo = WatchListRepository()
        var movieState = AppState(id: selectedMovie.id, watchList: repo.getWatchList())
        Store.shared.dispatch(action: movieListPresenter.isMovieInWatchList(movieID: selectedMovie.id) ? AppAction.remove : AppAction.add, appState: &movieState)
        self.movieListView.tableView.reloadData()
    }
    
    
    
}


class MovieListView: UIView {
    public let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardDismissMode = .interactive
        view.delaysContentTouches = false
        view.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.reuseIdentifier)
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = UIColor.clear
        
    }
}
