//
//  MainViewController.swift
//  CLEARExam
//
//  Created by John Lester Celis on 4/21/20.
//  Copyright © 2020 John Lester Celis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var model = [Movies]()
    private let apiFetcher = APIFetcher()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: MainViewControllerDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        fetchAPI()
        tableView.estimatedRowHeight = 1000.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delaysContentTouches = false
    }
    
    func setupData() {
        self.dataProvider.movies = model
        self.dataProvider.delegate = self
        self.tableView.dataSource = self.dataProvider
        self.tableView.delegate = self.dataProvider
        self.tableView.reloadData()
    }
    
    func registerCell() {
         tableView.register(MoviesTableViewCell.nib, forCellReuseIdentifier: "moviesCell")
     }

    func fetchAPI() {
        apiFetcher.fetchMovies { (results, error) in
            if case .failure = error {
                return
            }
            
            guard let results = results, !results.isEmpty else {
                return
            }
            
            for item in results {
                self.model.append(Movies(item))
            }
            self.setupData()
        }
    }

}

extension MainViewController: MainViewControllerDataProviderDelegate {
    func didSelectMovie(_ selectedMovie: Movies) {
        let vc : MovieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movie = selectedMovie
        vc.delegate = self
        let navController = UINavigationController(rootViewController: vc)
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

extension MainViewController: MovieDetailsViewControllerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}
