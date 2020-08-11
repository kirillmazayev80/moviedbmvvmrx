//
//  MovieCell.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var cardView: UIView!
    @IBOutlet fileprivate weak var backdropImg: UIImageView!
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    @IBOutlet fileprivate weak var overviewLbl: UILabel!
    
    
    func configureCell(with movie: Movie) {
        setCardViewProperties()
        titleLbl.text = movie.title
        overviewLbl.text = movie.descr
        setPoster(by: movie)
    }
    
    fileprivate func setPoster(by movie: Movie) {
        let fetchPosterUrlStr = Utils.IMAGE_PATH
        if let backdropPath = movie.backdropPath,
            let backdropUrl = URL(string: "\(fetchPosterUrlStr)\(backdropPath)") {
            self.backdropImg.sd_setImage(with: backdropUrl, completed: nil)
        } else {
            let noImage = UIImage(named: Utils.BACKDROP_NO_IMAGE)
            self.backdropImg.image = noImage
        }
    }
}
