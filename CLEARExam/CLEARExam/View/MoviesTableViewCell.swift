//
//  MoviesTableViewCell.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    static let nib:UINib = {
      return UINib(nibName: "\(MoviesTableViewCell.self)", bundle: nil)
    }()
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
    @IBOutlet weak var movieFavoriteImageView: UIImageView!
    var favorites: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getFavorites() {
        let def = UserDefaults.standard
        if let favorite = def.object(forKey: "favorites") {
            if let fav = favorite as? [String] {
                favorites = fav
            }
        }
    }
    
    func configureCell(with Movies: Movies) {
        let myDate = Date()
        movieImageView.image = nil
        movieImageView.loadImageUsingCache(withUrl: Movies.artworkUrl100, stringDate: myDate.asString(style: .short), defaultImage: UIImage(named: "default")!)
        movieImageView.roundCornersForAspectFit(radius: 8)
        movieTitleLabel.text = Movies.trackName
        movieGenreLabel.text = Movies.primaryGenreName
        moviePriceLabel.text = "$\(Movies.trackPrice)"
        getFavorites()
        
        
        if favorites.contains(Movies.trackName)  {
            movieFavoriteImageView.isHidden = false
        } else {
            movieFavoriteImageView.isHidden = true
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
