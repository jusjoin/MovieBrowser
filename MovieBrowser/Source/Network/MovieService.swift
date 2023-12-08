//
//  MovieService.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(searchString: String) async throws -> [Movie]
}

class MovieService: MovieServiceProtocol {
    let network: NetworkContract = Network()
    
    func fetchMovies(searchString: String) async throws -> [Movie] {
        let queryItems = [ URLQueryItem(name: "api_key", value: Constants.API.apiKey), URLQueryItem(name: "query", value: searchString)]
        guard var components = URLComponents(string: Constants.API.url) else { throw NetworkError.invalidQuery }
        components.queryItems = queryItems
        guard let url = components.string else { throw NetworkError.invalidQuery }
        let movies = try await network.request(url: url, modelType: MovieResponse.self)
        return movies.results.map {
            guard let posterPath = $0.posterPath else { return $0 }
            var movie = $0
            movie.posterPath = "\(Constants.API.imageURL)/\(posterPath)"
            return movie
        }
    }
}
