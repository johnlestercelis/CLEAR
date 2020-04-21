//
//  MovieDetailsViewController.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import UIKit

protocol MovieDetailsViewControllerDelegate {
    func reloadTableView()
}

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieFavoriteButton: UIButton!
    
    var movie: Movies?
    var favorites: [String] = []
    var delegate: MovieDetailsViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getFavorites()
        setupView()
    }
    
    func setupView() {
        let myDate = Date()
        if let mov = movie {
            movieImageView.loadImageUsingCache(withUrl: mov.artworkUrl100, stringDate: myDate.asString(style: .short), defaultImage: UIImage(named: "default")!)
            movieDescriptionLabel.text = mov.longDescription
            self.title = mov.trackName
            
            if favorites.contains(mov.trackName)  {
                movieFavoriteButton.setTitle("Remove to favorites", for: .normal)
                movieFavoriteButton.backgroundColor = .red
                movieFavoriteButton.tag = 2
            } else {
                movieFavoriteButton.setTitle("Add to favorites", for: .normal)
                movieFavoriteButton.backgroundColor = .green
                movieFavoriteButton.tag = 1
            }

        }
        
        movieFavoriteButton.layer.cornerRadius = 8.0
        movieFavoriteButton.clipsToBounds = true

    }
    
    func getFavorites() {
        let def = UserDefaults.standard
        if let favorite = def.object(forKey: "favorites") {
            if let fav = favorite as? [String] {
                favorites = fav
            }
        }
    }
    
    func removeFavorite() {
        let def = UserDefaults.standard
        if let mov = movie {
            favorites.remove(element: mov.trackName)
        }
        def.set(favorites, forKey: "favorites")
    }
    
    func addFavorite() {
        let def = UserDefaults.standard
        if let mov = movie {
            favorites.append(mov.trackName)
        }
        
        def.set(favorites, forKey: "favorites")
    }

    @IBAction func didPressDoneButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.reloadTableView()
        }
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.backgroundColor = .red
            sender.tag = 2
            sender.setTitle("Remove to favorites", for: .normal)
            addFavorite()
        } else {
            sender.backgroundColor = .green
            sender.tag = 1
            sender.setTitle("Add to favorites", for: .normal)
            removeFavorite()
        }
    }
}
