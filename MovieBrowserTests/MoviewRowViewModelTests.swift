//
//  MoviewRowViewModelTests.swift
//  MovieBrowserTests
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

import XCTest
@testable import MovieBrowser

class MovieRowViewModelTests: XCTestCase {
    private var sut: MovieRowViewModel!
    
    // Sample Data
    let movie = Movie(
        overview: "This movie about abou testing.",
        posterPath: nil,
        releaseDate: "2015-06-25",
        title: "The Testing Movie",
        voteAverage: 8.5236
    )

    override func setUp() {
        sut = MovieRowViewModel(movie: movie, selectionCallback: { _ in } )
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMovieRowTapped_NavigatesToDetailsWithCompletion() {
        var navigateToDetails = false
        
        sut = MovieRowViewModel(movie: movie, selectionCallback: { _ in
            navigateToDetails = true
        })
        sut.movieRowTapped()
        XCTAssertTrue(navigateToDetails)
    }

    // Computed Properties
    func testFormattedReleaseDate_DateFormattedToLongFormat() {
        let expectedDate = "June 25, 2015"
        let formattedDate = sut.releaseDate
        XCTAssertEqual(formattedDate, expectedDate)
    }

    func testFormattedAverageVote_AverageVotFormattedToSingleDecimalPlaceString() {
        let expectedAverageVote = "8.5"
        let formattedAverageVote = sut.averageVote
        XCTAssertEqual(formattedAverageVote, expectedAverageVote)
    }
}
