//
//  OverviewMovieVC+FloatActionBtn.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/14/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import Floaty

extension OverviewMovieVC {
    
    func setFloatActionBtn() {
        guard let vm = viewModel else { return }
        let floatyButton = Floaty()
        switch (vm.hasAdded.value) {
            case true: createDelActionBtn(floatyButton)
            case false: createAddAction(floatyButton)
        }
    }
    
    fileprivate func createAddAction(_ btn: Floaty) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onAddMovieToFavorites))
        btn.addGestureRecognizer(tapGesture)
        btn.setAddButton()
        view.addSubview(btn)
    }
    
    fileprivate func createDelActionBtn(_ btn: Floaty) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeleteMovieFromFavorites))
        btn.addGestureRecognizer(tapGesture)
        btn.setDeleteButton(frame: view.frame)
        view.addSubview(btn)
    }
    
    func removeActionBtn() {
        if let viewWithTag = self.view.viewWithTag(Utils.FAB_TAG) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    @objc
    fileprivate func onAddMovieToFavorites() {
        guard let vm = viewModel else { return }
        vm.onAddMovie()
        makeToast(with: Strings.HAS_ADDED_ALERT)
        vm.hasAdded.accept(!vm.hasAdded.value)
    }
    
    @objc
    fileprivate func onDeleteMovieFromFavorites() {
        guard let vm = viewModel else { return }
        vm.onRemoveMovie()
        makeToast(with: Strings.HAS_REMOVED_ALERT)
        vm.hasAdded.accept(!vm.hasAdded.value)
    }
    
}
