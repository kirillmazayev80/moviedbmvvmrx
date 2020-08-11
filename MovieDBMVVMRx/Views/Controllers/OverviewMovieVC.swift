//
//  OverviewMovieVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/14/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class OverviewMovieVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var backdropImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var budgetLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var descrTxt: UITextView!
    
    enum ImageType { case poster, backdrop }
    
    var viewModel: OverviewViewModel?
    weak var coordinator: MovieOverviewCoordinator?
    
    var isFullScreen = false
    fileprivate let disposeBag = DisposeBag()
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let vm = viewModel else { return }
        vm.isAdded()
    }
    
    // Binding movie's overview details
    fileprivate func bindViewModel() {
        guard let vm = self.viewModel else { return }
        
        vm.overview.subscribe(onNext: { [weak self] overview in
            guard let `self` = self,
                let overview = overview else { return }
            OverviewBinder.setOverview(vc: self, overview)
        }).disposed(by: disposeBag)
        
        vm.hasAdded.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.removeActionBtn()
            self.setFloatActionBtn()
        }).disposed(by: disposeBag)
        
        vm.errorMessages.subscribe(onNext: { [weak self] text in
            guard let `self` = self else { return }
            self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                  errorText: text)
        }).disposed(by: disposeBag)
        
        backdropImg.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.resizePosterFrame()
            }).disposed(by: disposeBag)
        
    }
    
}

extension OverviewMovieVC {
    func resizePosterFrame() {
        isFullScreen ? posterUnzoom() : posterZoom()
    }
    
    func posterZoom() {
        let posterImageView = UIImageView(frame: posterFrame())
        UIView.animate(withDuration: 0.3, animations:
            { [unowned self] in
                self.view.backgroundColor = .black
                self.view.subviews.forEach({ $0.alpha = 0 })
                self.addPosterOnSuperview(posterImageView)
        }) { [unowned self] (value) in
            self.setImage(on: posterImageView, by: .poster)
        }
        isFullScreen = true
    }
    
    func posterFrame() -> CGRect {
        let posterWidth: CGFloat = view.frame.width
        let posterHeight: CGFloat = Dims.POSTER_HEIGHT * posterWidth / Dims.POSTER_WIDTH
        let coordX: CGFloat = view.center.x - (posterWidth / 2)
        let coordY: CGFloat = view.center.y - (posterHeight / 2)
        return CGRect(x: coordX, y: coordY, width: posterWidth, height: posterHeight)
    }
    
    func posterUnzoom() {
        UIView.animate(withDuration: 0.3, animations:
            { [unowned self] in
                self.view.backgroundColor = .white
                self.view.subviews.forEach({ $0.alpha = 1 })
                self.removePosterFromSuperview()
        })
        isFullScreen = false
    }
    
    func addPosterOnSuperview(_ poster: UIImageView) {
        poster.isUserInteractionEnabled = true
        poster.tag = Utils.POSTER_TAG
        poster.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.resizePosterFrame()
            }).disposed(by: disposeBag)
        self.view.addSubview(poster)
    }
    
    func removePosterFromSuperview() {
        if let viewWithTag = self.view.viewWithTag(Utils.POSTER_TAG) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    func setImage(on imageView: UIImageView? = nil, by type: ImageType) {
        let fetchPosterStr = Utils.IMAGE_PATH
        switch (type) {
        case .poster:
            guard let overview = viewModel?.overview.value,
                let posterPath = overview.posterPath else { return }
            if let imagePathURL = URL(string: "\(fetchPosterStr)\(posterPath)") {
                imageView?.sd_setImage(with: imagePathURL, completed: nil)
            }
        case .backdrop:
            guard let backdropPath = viewModel?.movie?.backdropPath else { return }
            if let imagePathURL = URL(string: "\(fetchPosterStr)\(backdropPath)") {
                backdropImg.sd_setImage(with: imagePathURL, completed: nil)
            }
        }
    }
}
