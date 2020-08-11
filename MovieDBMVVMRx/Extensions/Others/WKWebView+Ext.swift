//
//  WKWebView+Ext.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/15/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import WebKit

extension WKWebView {
    
    // convert string to url and load request
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        load(request)
    }
    
}
