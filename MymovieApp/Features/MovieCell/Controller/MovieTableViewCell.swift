//
//  MovieTableViewCell.swift
//  MymovieApp
//
//  Created by Katya Miranda on 17/12/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    private var movieModel = MovieModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 2)
        shadowView.layer.shadowRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with movie: MovieModel.Movie) {
        movieTitle.text = movie.titleText.text
        
        releaseYearLabel.text = String(movie.releaseYear.year)
        
        if let imageURL = URL(string: movie.primaryImage.url){
            loadImage(with: imageURL)
        }
        
        
        
    }
    
    func loadImage(with url: URL){
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
               
                    DispatchQueue.main.async {self.movieImage.image = UIImage(data: data)}
            }
                
        }
        dataTask.resume()
        
    }
        
}
