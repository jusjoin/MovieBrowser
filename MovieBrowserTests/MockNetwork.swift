//
//  MockNetwork.swift
//  MovieBrowserTests
//
//  Created by Zane Francis on 12/7/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation
@testable import MovieBrowser

class MockMovieService: MovieServiceProtocol {
    var isSuccess: Bool = true
    var moviesToReturn: [Movie] = []

func fetchMovies(searchString: String) async throws -> [MovieBrowser.Movie] {
        if isSuccess {
            return moviesToReturn
        } else {
            throw NetworkError.decodingFailure
        }
    }
}
