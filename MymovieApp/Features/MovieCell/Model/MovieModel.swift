//
//  MovieModel.swift
//  MymovieApp
//
//  Created by Katya Miranda on 20/12/23.
//

import Foundation

class MovieModel {
    
    struct MovieResponse: Decodable {
        let results: [Movie]
    }

    struct Movie: Decodable {
        let id: String
        let primaryImage: PrimaryImage?
        let titleText: TitleText
        let releaseYear: ReleaseYear
        
        struct PrimaryImage: Decodable{
            let url: String
        }
        
        struct TitleText: Decodable {
            let text: String
        }
        
        struct ReleaseYear: Decodable {
            let year: Int
            let endYear: Int?
        }
        
    }

}
