//
//  Movie.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/6/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id = UUID()
    let overview: String
    var posterPath: String?
    let releaseDate: String
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
