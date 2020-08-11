//
//  OverviewBinder.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/14/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Foundation
import UIKit

class OverviewBinder {
    
    static func setOverview(vc: OverviewMovieVC, _ overview: Overview) {
        vc.setImage(by: .backdrop)
        vc.titleLbl.text = overview.title
        vc.releaseDateLbl.text = overview.releaseDate
        vc.voteCountLbl.text = "❤️ \(overview.voteCount)/\(overview.voteAverage)"
        vc.popularityLbl.text = "Popularity: \(overview.popularity)"
        vc.budgetLbl.text = "Budget: \(overview.budget/1_000_000)mln $"
        vc.langLbl.text = "Original language: \(overview.originalLang)"
        vc.descrTxt.text = overview.overview
    }
    
}
