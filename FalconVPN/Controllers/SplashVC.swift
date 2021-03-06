//
//  SplashVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/24/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var activityIndicat: UIActivityIndicatorView!
   
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicat.alpha = 1
        activityIndicat.startAnimating()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(stopAnimating), userInfo: nil, repeats: true)
    }

    @objc func stopAnimating() {
        timer?.invalidate()
        timer = nil
        activityIndicat.stopAnimating()
        UIApplication.shared.windows.first!.rootViewController = ContainerController()
    }
}
