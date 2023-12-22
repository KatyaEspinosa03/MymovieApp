//
//  MovieTableViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 17/12/23.
//

import UIKit

class MovieTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let movieTableViewCell = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(movieTableViewCell, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

   
}
