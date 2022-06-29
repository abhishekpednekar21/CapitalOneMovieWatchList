//
//  WatchListViewController.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import UIKit
import Combine

class WatchListViewController: UIViewController {

    var watchListView =  WatchListView()
    var watchListPresenter: WatchListPresenterProtocol!
    private var cancellables = Set<AnyCancellable>()
    let presetControlPassthroughSubject = PassthroughSubject<String,Never>()
//
    private var movies = [Movies](){
        didSet{
            watchListView.tableView.reloadData()
        }
    }

    
    
    @available(*,unavailable,renamed: "init()")
    required init?(coder:NSCoder){
        super.init(coder: coder)!
    }
    
    init(with presenter: WatchListPresenterProtocol) {
        self.watchListPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        self.title = "Watch List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        navigationController?.navigationBar.backgroundColor = .black
        
        self.view.addSubview(self.watchListView.tableView)
        self.view.addSubview(self.watchListView.label)
        
        setUpLabel()
        setupTableView()
        sinkToPublishers()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClicked))
        navigationController?.navigationBar.tintColor = .systemYellow

    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        guard let presenterProtocol = self.watchListPresenter else {
            print ("Not initialised")
            return
        }
        presenterProtocol.initial()
        self.movies = presenterProtocol.getWatchListMovies()
        
        self.watchListView.label.isHidden = true

        
        
    }
    
    private func sinkToPublishers() {
        watchListPresenter?.watchListPublisher.sink {
            self.watchListView.tableView.reloadData()
            if self.watchListPresenter.moviesCount() == 0 {
                self.setUpLabel()
            }

        }.store(in: &cancellables)
    }
    
    @objc func addClicked() {
        let movieListVC = MovieListViewController(with: MovieListPresenter(interactor: MovieListInteractor(apiService: APIService())))
        self.navigationController?.pushViewController(movieListVC, animated: true)
    }
    
 
    private func setupTableView() {
        self.watchListView.tableView.delegate = self
        self.watchListView.tableView.dataSource = self
        self.watchListView.tableView.constrainToFillSuperview()
        self.watchListView.tableView.rowHeight = UITableView.automaticDimension
        self.watchListView.tableView.separatorColor = .white
    }
    
    func setUpLabel(){
        self.watchListView.label.isHidden = false
        self.watchListView.label.constrainToFillSuperview()
    }
    
}


extension WatchListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.watchListPresenter.moviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.watchListView.tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as? WatchListTableViewCell else {
            return UITableViewCell()
        }
        cell.separatorInset = UIEdgeInsets.zero

        
        cell.thumbnailImage.image = UIImage(named: "SchittsCreek")
        cell.selectionStyle = .none

        
        let movie = watchListPresenter.getCurrentMovie(at: indexPath.row)
        cell.nameLabel.text = movie.title
        cell.imdbScoreLabel.text = "Year released : \(movie.year)"
        cell.thumbnailImage.loadImageUsingCacheWithUrlString(urlString: movie.image ?? "")


       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                let selectedMovie = watchListPresenter.getCurrentMovie(at: indexPath.row)
                let repo = WatchListRepository()
                var movieState = AppState(id: selectedMovie.id, watchList: repo.getWatchList())
                Store.shared.dispatch(action: AppAction.remove , appState: &movieState)
                watchListPresenter.updateMovieList()
                 presetControlPassthroughSubject.send(selectedMovie.id)
            }
        }
}


class WatchListView : UIView {
    
    public let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardDismissMode = .interactive
        view.delaysContentTouches = false
        view.register(WatchListTableViewCell.self, forCellReuseIdentifier: WatchListTableViewCell.reuseIdentifier)
        return view
    }()
    
    
    public let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
     public let buttonAdd: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
    
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
        
        self.label.text = "\n No movies added yet 🤥 \n Click the '+' on top to add movies to watch list.🍿"
        self.label.numberOfLines = 0
        self.label.font = UIFont(name: "Helvetica-Bold", size: 20.0)
        self.label.textAlignment = .center
        self.label.textColor = .systemYellow
    }
    
    
}

