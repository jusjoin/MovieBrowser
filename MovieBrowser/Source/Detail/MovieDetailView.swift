//
//  MovieDetailView.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/6/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    let viewModel: MovieDetailViewModel

    var body: some View {
        VStack {
            Text(viewModel.movie.title)
                .font(.title2)
            releaseDate
            HStack(spacing: 8) {
                poster
                Text(viewModel.movie.overview)
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)
            Spacer()
        }
        .padding(.top, 32)
    }

    var releaseDate: some View {
        Group {
            Text("Release Date: ") +
            Text(viewModel.movie.releaseDate)
        }
            .font(.subheadline)
            .foregroundColor(.gray)
    }

    var poster: some View {
        AsyncImage(url: URL(string: viewModel.movie.posterPath ?? "")){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        } placeholder: {
            Image(uiImage: UIImage(named: "placeholder") ?? UIImage())
        }
        
    }
}

#Preview {
    let overview = "This is the movie overview of a great movie. This is the movie overview of a great movie. This is the movie overview of a great movie. This is the movie overview of a great movie. This is the movie overview of a great movie."
    let movie = Movie(
        id: 0,
        overview: overview,
        posterPath: "",
        releaseDate: "2015-06-25",
        title: "Star Wars: The Force Awakens",
        voteAverage: 10.0
    )
    return MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))
}
