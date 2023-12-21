//
//  MovieTableViewCell.swift
//  MymovieApp
//
//  Created by Katya Miranda on 17/12/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    
    
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
    
}
