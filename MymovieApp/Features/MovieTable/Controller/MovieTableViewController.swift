//
//  MovieTableViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 17/12/23.
//

import UIKit

class MovieTableViewController: UITableViewController {
        
    var movies: [MovieModel.Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovieData()
        
        let movieTableViewCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(movieTableViewCell, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        
        let movie = movies[indexPath.row]
        cell.configureCell(with: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func fetchMovieData(){
        let movieService = MovieService(apiClient: APIClient(
            headers:  [
            "X-RapidAPI-Key": "4628b3ca27msh9c7282376d9f318p1ed571jsn71c004e33816",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
        ], 
            url:  URL(string: "https://moviesdatabase.p.rapidapi.com/titles")!,
            httpMethod: .get))
        
        movieService.getMovieData { result in
            switch result {
            case .success(let movieResponse):
                
                self.movies = movieResponse.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case.failure(let error):
                print("Error fetching movie data: \(error.localizedDescription)" )
            }
        }
    }
   
}
