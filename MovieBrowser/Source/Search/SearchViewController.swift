//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        let hostingViewController = UIHostingController(rootView: MoviesSearchView(viewModel: MoviesSearchViewModel(selectionCallback: didSelectMovie)))
        
        if let searchView = hostingViewController.view {
            searchView.frame = self.view.bounds
            self.view.addSubview(searchView)
        }
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
              let statusBarView = UIView(frame: windowScene.statusBarManager?.statusBarFrame ?? .zero)
        statusBarView.backgroundColor = .systemBlue
        windowScene.keyWindow?.addSubview(statusBarView)
    }

    func didSelectMovie(movie: Movie) {
        let detailsViewController = MovieDetailViewController(movie: movie)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        print("Movie selected: \(movie.title)")
    }

}
