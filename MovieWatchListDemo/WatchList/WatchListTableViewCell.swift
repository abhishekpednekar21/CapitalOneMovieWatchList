//
//  WatchListTableViewCell.swift
//  MovieWatchListDemo
//
//  Created by Abhishek Pednekar on 2022-06-22.
//

import Foundation
import UIKit

class WatchListTableViewCell : UITableViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    
    public let thumbnailImage: UIImageView = {
        let thumbnailImage = UIImageView()
        thumbnailImage.contentMode = .scaleToFill
        thumbnailImage.clipsToBounds = true
         return thumbnailImage
    }()

    public let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        nameLabel.textColor = UIColor.systemYellow
        nameLabel.text = "Schitt's Creek"
         return nameLabel
    }()

    public let imdbScoreLabel: UILabel = {
        let imdbScoreLabel = UILabel()
        imdbScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        imdbScoreLabel.textAlignment = .left
        imdbScoreLabel.numberOfLines = 0
        imdbScoreLabel.font = UIFont.systemFont(ofSize: 16.0)
        imdbScoreLabel.text = "IMDB Score : 8.9"
        imdbScoreLabel.textColor = UIColor.white
        return imdbScoreLabel
    }()
    

    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .gray
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .black

        addSubview(self.thumbnailImage)
        addSubview(self.nameLabel)
        addSubview(self.imdbScoreLabel)
 
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
                              width: 60,
                              height: 80,
                              enableInsets: false)
    
        nameLabel.anchor(top: topAnchor,
                            left: thumbnailImage.rightAnchor,
                            bottom: imdbScoreLabel.topAnchor,
                            right: nil,
                            paddingTop: 10.0,
                            paddingLeft: 10.0,
                            paddingBottom: 10.0,
                            paddingRight: 5.0,
                            width: 300.0,
                            height: 30.0,
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
        
    }
}
