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
        let _id: String
        let id: String
        let primaryImage: PrimaryImage
        let titleType: TitleType
        let titleText: TitleText
        let originalTitleText: TitleText
        let releaseYear: ReleaseYear
        let releaseDate: String?
        
        struct PrimaryImage: Decodable{
            let id: String
            let width: Int
            let height: Int
            let url: String
            let caption: Caption
            let __typename: String
        }
        
        struct Caption: Decodable{
            let plainText: String
            let __typename: String
        }
        
        struct TitleType: Decodable {
            let text: String
            let id: String
            let isSeries: Bool
            let isEpisoe: Bool
            let __typename: String
        }
        
        struct TitleText: Decodable {
            let text: String
            let __typename: String
        }
        
        struct ReleaseYear: Decodable {
            let year: Int
            let endYear: Int?
            let __typename: String
        }
        
    }

}
