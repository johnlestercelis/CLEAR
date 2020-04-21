//
//  MainViewControllerDataProvider.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import UIKit

protocol MainViewControllerDataProviderDelegate {
    func didSelectMovie(_ selectedMovie: Movies)
}

class MainViewControllerDataProvider: NSObject {
    var movies = [Movies]()
    var delegate: MainViewControllerDataProviderDelegate?
}

extension MainViewControllerDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = movies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as? MoviesTableViewCell {
            cell.configureCell(with: content)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension MainViewControllerDataProvider: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedMovie = movies[indexPath.row]
         delegate?.didSelectMovie(selectedMovie)
        tableView.deselectRow(at: indexPath, animated: false)

    }
}
