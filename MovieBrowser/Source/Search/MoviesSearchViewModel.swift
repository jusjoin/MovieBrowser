//
//  MoviesSearchViewModel.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/6/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class MoviesSearchViewModel: ObservableObject {
    @Published var searchedText: String = ""
    @Published var debouncedSearchText: String = ""
    @Published var movies = [Movie]()
    @Published var isError: Bool = false
    let selectionCallback: (Movie) -> ()
    private let movieService: MovieServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(
        movieService: MovieServiceProtocol = MovieService(),
        selectionCallback: @escaping (Movie) -> () = { _ in }
    ) {
        self.movieService = movieService
        self.selectionCallback = selectionCallback
        setupSearchDebounce()
    }

    @MainActor
    func searchMovies() async {
        do {
            let results = try await movieService.fetchMovies(searchString: searchedText)
            self.movies = results
        } catch let error {
            self.isError = true
            print("Error: \(error.localizedDescription)")
        }
    }

    func movieRow(movie: Movie) -> some View {
        MovieRow(viewModel: MovieRowViewModel(
            movie: movie,
            selectionCallback: selectionCallback)
        )
    }

    func clearSearchTapped() {
        searchedText = ""
        movies = []
    }

    func setupSearchDebounce() {
        $searchedText
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
        }
}
