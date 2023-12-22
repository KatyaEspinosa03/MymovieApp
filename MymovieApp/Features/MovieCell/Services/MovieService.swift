//
//  MovieService.swift
//  MymovieApp
//
//  Created by Katya Miranda on 20/12/23.
//

import Foundation


class MovieService {
    
    private let movieResponse = MovieModel()
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = APIClient(
            headers:  [
            "X-RapidAPI-Key": "4628b3ca27msh9c7282376d9f318p1ed571jsn71c004e33816",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
        ], 
            url: URL(string: "https://moviesdatabase.p.rapidapi.com/titles")!,
            httpMethod: .get)
    }
    
    public func getMovieData(completion: @escaping (Result<MovieModel.MovieResponse, Swift.Error>) -> Void) {
        apiClient.executeService { data, response, error in
            DispatchQueue.main.async{
                if let error = error {
                    completion(.failure(error))
                }else if let response = response as? HTTPURLResponse,
                         response.statusCode == 200, let data = data {
                    do {
                        let movieResponse = try JSONDecoder().decode(MovieModel.MovieResponse.self, from: data)
                        completion(.success(movieResponse))
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

