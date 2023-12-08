//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import SwiftUI

class MovieDetailViewController: UIViewController { 
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let hostingViewController = UIHostingController(rootView: MovieDetailView(viewModel: MovieDetailViewModel(movie: movie)))
        
        if let detailView = hostingViewController.view {
            detailView.frame = self.view.bounds
            self.view.addSubview(detailView)
        }
    }
}
