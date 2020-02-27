//
//  SafariVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/27/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit
import WebKit

class SafariVC: UIViewController {

    var webView = WKWebView()
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        if let url = URL(string: url) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
        
    func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
