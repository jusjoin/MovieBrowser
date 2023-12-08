//
//  MovieRowViewModel.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MovieRowViewModel {
    let movie: Movie
    let selectionCallback: (Movie) -> ()

    init(
        movie: Movie,
        selectionCallback: @escaping (Movie) -> () = { _ in }
    ) {
        self.movie = movie
        self.selectionCallback = selectionCallback
    }

    var releaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            return dateFormatter.string(from: date)
        } else {
            return movie.releaseDate
        }
    }

    var averageVote: String {
        String(format: "%.1f", movie.voteAverage)
    }
    
    func movieRowTapped() {
        selectionCallback(movie)
    }
}
