//
//  MovieListTableViewCell.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import UIKit

class MovieListTableViewCell : UITableViewCell {
   
    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    
    public lazy var thumbnailImage: UIImageView = {
        let thumbnailImage = UIImageView()
        thumbnailImage.contentMode = .scaleToFill
        thumbnailImage.clipsToBounds = true
        return thumbnailImage
    }()

    public lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        nameLabel.textColor = UIColor.systemYellow
        return nameLabel
    }()

    public lazy var imdbScoreLabel: UILabel = {
        let imdbScoreLabel = UILabel()
        imdbScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        imdbScoreLabel.textAlignment = .left
        imdbScoreLabel.numberOfLines = 0
        imdbScoreLabel.font = UIFont.systemFont(ofSize: 14.0)
        imdbScoreLabel.text = ""
        imdbScoreLabel.textColor = UIColor.white
        return imdbScoreLabel
    }()
    
    public lazy var yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.textAlignment = .left
        yearLabel.numberOfLines = 0
        yearLabel.font = UIFont.systemFont(ofSize: 14.0)
        yearLabel.textColor = UIColor.white
        return yearLabel
    }()
    
    public lazy var genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.textAlignment = .left
        genreLabel.numberOfLines = 0
        genreLabel.font = UIFont.systemFont(ofSize: 14.0)
        genreLabel.textColor = UIColor.white
        return genreLabel
    }()
 
    public lazy var addMovieButton : UIButton = {
        let addMovieButton = UIButton()
        addMovieButton.setTitle("✓", for: .normal)
        addMovieButton.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
        addMovieButton.layer.cornerRadius = 15
        addMovieButton.layer.borderWidth = 1.0
        addMovieButton.layer.borderColor = UIColor.systemYellow.cgColor
        addMovieButton.setTitleColor(.systemYellow, for: .normal)
        
        return addMovieButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .black
        
        
        addSubview(self.thumbnailImage)
        addSubview(self.nameLabel)
        addSubview(self.imdbScoreLabel)
        addSubview(self.yearLabel)
        addSubview(self.genreLabel)
        addSubview(self.addMovieButton)
 
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        thumbnailImage.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: nil,
                              paddingTop: 10.0,
                              paddingLeft: 10.0,
                              paddingBottom: 15.0,
                              paddingRight: 10.0,
                              width: 80,
                              height: 150,
                              enableInsets: false)
    
        nameLabel.anchor(top: topAnchor,
                            left: thumbnailImage.rightAnchor,
                            bottom: imdbScoreLabel.topAnchor,
                            right: nil,
                            paddingTop: 20.0,
                            paddingLeft: 10.0,
                            paddingBottom: 10.0,
                            paddingRight: 5.0,
                            width: 200.0,
                            height: 20.0,
                            enableInsets: true)
        
        imdbScoreLabel.anchor(top: nameLabel.bottomAnchor,
                              left: thumbnailImage.rightAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 0.0,
                              paddingLeft: 10.0,
                              paddingBottom: 10.0,
                              paddingRight: 5.0,
                              width: 200.0,
                              height: 20.0,
                              enableInsets: true)
        
        yearLabel.anchor(top: imdbScoreLabel.bottomAnchor,
                              left: thumbnailImage.rightAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 0.0,
                              paddingLeft: 10.0,
                              paddingBottom: 5.0,
                              paddingRight: 5.0,
                              width: 200.0,
                              height: 20.0,
                              enableInsets: true)

        genreLabel.anchor(top: yearLabel.bottomAnchor,
                              left: thumbnailImage.rightAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 0.0,
                              paddingLeft: 10.0,
                              paddingBottom: 10.0,
                              paddingRight: 5.0,
                              width: 200.0,
                              height: 50.0,
                              enableInsets: true)
        
        addMovieButton.anchor(top: nil,
                              left: genreLabel.rightAnchor,
                              bottom: nil,
                              right: rightAnchor,
                              paddingTop: 0.0,
                              paddingLeft: 10.0,
                              paddingBottom: 0.0,
                              paddingRight: 15.0,
                              width: 30.0,
                              height: 30.0,
                              enableInsets: true)

        addMovieButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
