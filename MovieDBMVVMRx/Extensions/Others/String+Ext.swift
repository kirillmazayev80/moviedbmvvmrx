//
//  Strings+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import Foundation

extension String {
    
    // convert string to date
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    
    // string localizing
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
