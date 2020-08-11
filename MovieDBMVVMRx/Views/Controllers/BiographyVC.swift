//
//  BiographyVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift


class BiographyVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var portraitImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var birthPlaceLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var homepageLbl: UILabel!
    @IBOutlet weak var bioTxt: UITextView!
    
    var viewModel: BioViewModel?
    weak var coordinator: BioCoordinator?
    
    fileprivate let disposeBag = DisposeBag()
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // Bind biography details
    fileprivate func bindViewModel() {
        guard let vm = self.viewModel else { return }
        
        vm.bio
            .subscribe(onNext: { [weak self] bio in
                guard let `self` = self,
                    let bio = bio else { return }
                BioBinder.setBio(vc: self, bio)
            }).disposed(by: disposeBag)
        
        vm.errorMessages.subscribe (onNext: { [weak self] text in
            guard let `self` = self else { return }
            self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                  errorText: text)
        }).disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        homepageLbl.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .bind(onNext: { [weak self] recognizer in
                guard let `self` = self,
                    let urlStr = self.homepageLbl.attributedText?.string else { return }
                self.coordinator?.transitToHomePage(with: urlStr)
            }).disposed(by: disposeBag)
    }
    
}
