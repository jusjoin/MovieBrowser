//
//  MovieSearchViewModelTests.swift
//  MovieBrowserTests
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation

import XCTest
@testable import MovieBrowser

class MovieSearchViewModelTests: XCTestCase {
    private var sut: MoviesSearchViewModel!
    private var mockService: MockMovieService!
    
    // Sample Data
    let movie = Movie(
        overview: "This movie about abou testing.",
        posterPath: nil,
        releaseDate: "2017-06-06",
        title: "The Testing Movie",
        voteAverage: 10.0
    )

    override func setUp() {
        mockService = MockMovieService()
        mockService.moviesToReturn = [movie]
        sut = MoviesSearchViewModel(movieService: mockService)
    }

    override func tearDown() {
        mockService = nil
        sut = nil
    }

    func testSearchButtonTapped_ServiceCallSuccess_MoviesFetched() {
        let expectation = XCTestExpectation(description: "Return non empty Movie array from service call.")
        XCTAssertTrue(sut.movies.isEmpty)
        Task {
            await sut.searchMovies()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertFalse(sut.movies.isEmpty)
    }
    
    func testSearchButtonTapped_ServiceCallFail_IsErrorTrue() {
        mockService.isSuccess = false
        let expectation = XCTestExpectation(description: "MovieSearchViewModel error flag isError set to true.")
        XCTAssertFalse(sut.isError)
        Task {
            await sut.searchMovies()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(sut.isError)
    }
    
    func testClearSearchButtonTapped_SearchedTextCleared() {
        sut.searchedText = "Movie"
        sut.clearSearchTapped()
        XCTAssertTrue(sut.searchedText.isEmpty)
    }

    func testClearSearchButtonTapped_MoviesCleared() {
        sut.movies = [movie]
        sut.clearSearchTapped()
        XCTAssertTrue(sut.movies.isEmpty)
    }

}
