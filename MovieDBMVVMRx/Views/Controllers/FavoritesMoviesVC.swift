//
//  FavoritesMoviesVC.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBiBinding

class FavoritesMoviesVC: UIViewController, UICollectionViewDelegate,
Storyboarded {
    
    @IBOutlet weak var favoritesGallery: UICollectionView!
    @IBOutlet weak var sortFavoritesSegmCtrl: UISegmentedControl!
    
    var viewModel: FavoritesViewModel?
    weak var coordinator: FavoritesMoviesCoordinator?
    
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    // MARK: - Custom
    fileprivate func setUserInterface(){
        favoritesGallery.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        (sortFavoritesSegmCtrl.rx.selectedSegmentIndex  <->  vm.sortingType)
            .disposed(by: disposeBag)
        
        vm.sortedMovies.asDriver()
            .drive(favoritesGallery.rx.items(cellIdentifier: Utils.FAVORITES_CELL))
            { _, movie, cell in
                guard let cell = cell as? FavoritesCell else { return }
                cell.configureCell(with: movie)
            }.disposed(by: disposeBag)
        
        favoritesGallery.rx.itemSelected
            .subscribe (onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                let movie = vm.sortedMovies.value[indexPath.row]
                self.coordinator?.transitToOverview(with: movie)
        }).disposed(by: disposeBag)
        
        vm.errorMessages
            .subscribe (onNext: { [weak self] text in
                guard let `self` = self else { return }
                self.showErrorMessage(title: Strings.INTERNAL_ERR_TITLE,
                                  errorText: text)
        }).disposed(by: disposeBag)
    }
    
}
