//
//  BioBinder.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class BioBinder {
    
    static func setBio(vc: BiographyVC, _ bio: Bio) {
        vc.title = bio.name
        setPortrait(vc, by: bio)
        vc.nameLbl.text = bio.name
        vc.birthdayLbl.text = bio.birthday
        vc.birthPlaceLbl.text = bio.placeOfBirth
        vc.popularityLbl.text = "Popularity: \(bio.popularity)"
        if let homepage = bio.homepage {
            let attributedText = NSMutableAttributedString(string: homepage)
            attributedText.addAttributes([.foregroundColor: UIColor.blue,
                                          .underlineStyle: NSUnderlineStyle.single.rawValue],
                                         range: NSMakeRange(0, homepage.count))
            vc.homepageLbl.attributedText = attributedText
            vc.homepageLbl.isUserInteractionEnabled = true
        } else {
            vc.homepageLbl.text = "Home page: is missing"
        }
        vc.bioTxt.text = bio.biography
    }
    
    fileprivate static func setPortrait(_ vc: BiographyVC, by bio: Bio) {
        let fetchPosterStr = Utils.IMAGE_PATH
        if let profilePath = bio.profilePath,
            let profilePathURL = URL(string: "\(fetchPosterStr)\(profilePath)") {
            vc.portraitImg.sd_setImage(with: profilePathURL, completed: nil)
        } else {
            let noImage = UIImage(named: Utils.POSTER_NO_IMAGE)
            vc.portraitImg.image = noImage
        }
    }
    
}
