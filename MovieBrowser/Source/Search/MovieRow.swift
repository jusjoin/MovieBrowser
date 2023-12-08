//
//  MovieRow.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    let viewModel: MovieRowViewModel

    var body: some View {
        Button {
            viewModel.movieRowTapped()
        } label : {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.movie.title)
                            .font(.title)
                            .padding(.bottom, 12)
                            .padding(.trailing, 24)
                        Text(viewModel.releaseDate)
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    Spacer()
                    HStack {
                        Text(viewModel.averageVote)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(.gray)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    let movie = Movie(
        id: 0,
        overview: "This is the movie overview of a great movie",
        posterPath: "",
        releaseDate: "December 25th, 1997",
        title: "Star Wars: The Force Awakens",
        voteAverage: 10.1525
    )
    return MovieRow(viewModel: MovieRowViewModel(movie: movie))
}
