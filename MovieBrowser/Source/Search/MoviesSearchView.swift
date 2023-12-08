//
//  MoviesSearchView.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/6/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MoviesSearchView: View {
    @ObservedObject var viewModel: MoviesSearchViewModel

    var body: some View {
        VStack {
            searchBar
            movieList
        }
        .alert("Error", isPresented: $viewModel.isError) {
            Button("Sorry we have encountered an error. Please try again.", role: .cancel) { }
        }
    }

    var searchBar: some View {
        HStack(alignment: .center, spacing: .zero) {
            VStack(spacing: .zero) {
                searchTextField
                Divider()
            }
            Button(action: {
                Task {
                    hideKeyboard()
                    await viewModel.searchMovies()
                }
            }) {
                Text("Go")
                    .font(.footnote)
                    .opacity(viewModel.searchedText.isEmpty ? 0 : 1)
            }
            .padding(.trailing, 16)
        }
    }

    var searchTextField: some View {
        HStack(alignment: .center) {
          Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(.gray)
            .padding(.leading, -8)
            TextField("Search", text: $viewModel.searchedText)
                .onChange(of: viewModel.debouncedSearchText) {
                    Task {
                        await viewModel.searchMovies()
                    }
                }
            Button {
                viewModel.clearSearchTapped()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray)
                    .padding(.trailing, -8)
            }
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(UIColor.lightGray))
            .opacity(0.3)
            .frame(maxHeight: 32)
        )
        .padding(.horizontal)
    }

    var movieList: some View {
         List {
        ForEach(viewModel.movies, id: \.id) { movie in
            viewModel.movieRow(movie: movie)
        }
        .padding(.horizontal, 12)
         }
         .listStyle(.plain)
    }
}

#Preview {
    let viewModel = MoviesSearchViewModel()
    let movie = Movie(overview: "This is the movie overview of a great movie",
                      posterPath: "",
                      releaseDate: "December 25th, 1997",
                      title: "Star Wars: The Force Awakens",
                      voteAverage: 10.1525)
    viewModel.movies = [movie]
    return MoviesSearchView(viewModel: viewModel)
}
