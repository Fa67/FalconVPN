//
//  MainScreenVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/24/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var chooseServerView: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var forestBottomConstraint: NSLayoutConstraint!
    
    
    var imageAnimateTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let choosePlanVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChoosePlanTVC") as! ChoosePlanTVC
        
        choosePlanVC.modalPresentationStyle = .fullScreen
        self.present(choosePlanVC, animated: true, completion: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func setupView() {
        connectButton.isHidden = true
        statusLabel.isHidden = true
        logoImage.isHidden = true
        chooseServerView.isHidden = true
        self.connectButton.isEnabled = false

        imageAnimateTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(imageAnimate), userInfo: nil, repeats: true)
    }
    
    @objc func imageAnimate() {
        
        imageAnimateTimer?.invalidate()
        imageAnimateTimer = nil
        
        view.layoutIfNeeded()
        forestBottomConstraint.constant = 312
        chooseServerView.alpha = 0
        connectButton.alpha = 0
        statusLabel.alpha = 0
        logoImage.alpha = 0
        chooseServerView.isHidden = false
        connectButton.isHidden = false
        statusLabel.isHidden = false
        logoImage.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.chooseServerView.alpha = 1
            self.connectButton.alpha = 1
            self.statusLabel.alpha = 1
            self.logoImage.alpha = 1
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.connectButton.isEnabled = true
        }
        
    }
    
}
