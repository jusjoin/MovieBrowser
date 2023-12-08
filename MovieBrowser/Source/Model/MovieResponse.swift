//
//  MovieResponse.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/6/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
