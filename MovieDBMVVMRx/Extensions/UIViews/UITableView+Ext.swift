//
//  UITableView+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/23/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


extension UITableView {
    
    var disposeBag: DisposeBag {
        return DisposeBag()
    }
    
    var rx_loadNextPageTrigger: Observable<Bool> {
        return self.rx.contentOffset.asObservable()
            .map { offset in
                self.isNearBottomEdge(contentOffset: offset.y)
            }
    }
    
    private func  isNearBottomEdge(contentOffset: CGFloat, edgeOffSet: CGFloat = 30) -> Bool {
        return contentOffset + self.frame.size.height + edgeOffSet > self.contentSize.height
    }
    
}
