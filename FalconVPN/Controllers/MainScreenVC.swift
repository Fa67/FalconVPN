//
//  MainScreenVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/24/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

protocol ChangeServerDelegate: class {
    func changeServer(countryIndex: Int)
}

class MainScreenVC: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var chooseServerView: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var forestBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var mapBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var blackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var choosePlanButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var timerLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var serverFlagImage: UIImageView!
    @IBOutlet weak var serverCountryLabel: UILabel!
    @IBOutlet weak var activityIndicat: UIActivityIndicatorView!
    
    var delegate: HomeControllerDelegate?

    private var imageAnimateTimer: Timer?
    private var secondsTimer: Timer?
    
    var seconds = 0 {
        didSet {
            self.timerLabel.text = secondsToHoursMinutesSeconds(seconds: seconds)
        }
    }
    
    var isConnected = false {
        didSet {
            if isConnected {
                connectSetupView()
            } else {
                disconnectSetupView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presentPlans()
        setupGestures()
    }
    
    @IBAction func connect(_ sender: UIButton) {
        if isConnected {
            isConnected = !isConnected
        } else {
            connectButton.isUserInteractionEnabled = false
            activityIndicat.isHidden = false
            activityIndicat.startAnimating()
            imageAnimateTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(animateView), userInfo: nil, repeats: true)
        }
    }
    
    @objc func animateView() {
        activityIndicat.stopAnimating()
        activityIndicat.isHidden = true
        imageAnimateTimer?.invalidate()
        imageAnimateTimer = nil
        isConnected = !isConnected
    }
    
    private func mapViewAnimate() {
        self.view.layoutIfNeeded()
        self.mapImage.isHidden = false
        self.mapImage.alpha = 0
        mapBottomConstraint.constant = 210
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.mapImage.alpha = 1
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.connectButton.isUserInteractionEnabled = true
        }
    }
    
    private func setupView() {
        let currentServerIndex = UserDefaults.standard.integer(forKey: Constants.currentServerKey)
        let flagImage = Constants.flags[currentServerIndex]
        let countryName = Constants.countryNames[currentServerIndex]
        serverFlagImage.image = UIImage(named: flagImage)
        serverCountryLabel.text = countryName
        navigationItem.title = " "
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = true
        connectButton.isUserInteractionEnabled = false
        chooseServerView.isHidden = true
        activityIndicat.isHidden = true
        connectButton.isHidden = true
        statusLabel.isHidden = true
        timerLabel.isHidden = true
        logoImage.isHidden = true
        mapImage.isHidden = true
        imageAnimateTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(imageAnimate), userInfo: nil, repeats: true)
    }
    
    private func connectSetupView() {
        view.layoutIfNeeded()
        connectButton.setBackgroundColor(color: #colorLiteral(red: 0.1254901961, green: 0.1333333333, blue: 0.1529411765, alpha: 1), forState: .normal)
        connectButton.setTitle("Disconnect", for: .normal)
        connectButton.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        statusLabel.text = "Connected"
        statusLabel.textColor = #colorLiteral(red: 0.003921568627, green: 0.6901960784, blue: 0.4588235294, alpha: 1)
        blackViewHeightConstraint.constant += 700
        forestBottomConstraint.constant += 700
        connectButton.isUserInteractionEnabled = false
        statusLabelBottomConstraint.constant = 110
        timerLabelBottomConstraint.constant = 68
        timerLabel.isHidden = false
        logoImage.isHidden = true
        timerLabel.alpha = 0
        mapImage.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.timerLabel.alpha = 1
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.secondsTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            self.menuButton.setImage(#imageLiteral(resourceName: "ic_whiteMenu"), for: .normal)
            self.choosePlanButton.setImage(#imageLiteral(resourceName: "ic_whitePrice"), for: .normal)
            self.mapViewAnimate()
        }
    }
    
    private func disconnectSetupView() {
        view.layoutIfNeeded()
        secondsTimer?.invalidate()
        secondsTimer = nil
        seconds = 0
        connectButton.setBackgroundColor(color: #colorLiteral(red: 0.003921568627, green: 0.6901960784, blue: 0.4588235294, alpha: 1), forState: .normal)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.isUserInteractionEnabled = false
        connectButton.borderColor = #colorLiteral(red: 0.1254901961, green: 0.1333333333, blue: 0.1529411765, alpha: 1)
        statusLabel.text = "Disconnected"
        statusLabel.textColor = #colorLiteral(red: 0.6156862745, green: 0.6196078431, blue: 0.6274509804, alpha: 1)
        logoImage.isHidden = false
        statusLabelBottomConstraint.constant = 75
        blackViewHeightConstraint.constant -= 700
        timerLabelBottomConstraint.constant = 40
        forestBottomConstraint.constant -= 700
        mapBottomConstraint.constant -= 100
        mapBottomConstraint.constant = 171
        mapImage.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
            self.mapImage.alpha = 0
            self.timerLabel.alpha = 0
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.connectButton.isUserInteractionEnabled = true
            self.choosePlanButton.setImage(#imageLiteral(resourceName: "ic_buy"), for: .normal)
            self.menuButton.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
            self.timerLabel.isHidden = true
            self.mapImage.isHidden = true
        }
    }
    
    private func setupGestures() {
        let chooseServerTap = UITapGestureRecognizer(target: self, action: #selector(self.chooseServerTapped(_:)))
        chooseServerView.addGestureRecognizer(chooseServerTap)
        choosePlanButton.addTarget(self, action: #selector(choosePlanTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    func presentPlans() {
        let choosePlanVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChoosePlanTVC") as! ChoosePlanTVC
        choosePlanVC.modalPresentationStyle = .fullScreen
        self.present(choosePlanVC, animated: true, completion: nil)
    }
    
    @objc func menuButtonTapped() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    @objc func chooseServerTapped(_ sender: UITapGestureRecognizer? = nil) {
        let chooseServerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseServerVC") as! ChooseServerVC
        let currentServerIndex = UserDefaults.standard.integer(forKey: Constants.currentServerKey)
        chooseServerVC.title = "Choose Server"
        chooseServerVC.delegate = self
        chooseServerVC.selectedIndex = currentServerIndex
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(chooseServerVC, animated: true)
    }
    
    @objc func choosePlanTapped() {
        let chooseServerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePlanVC") as! ChangePlanVC
        chooseServerVC.title = "Choose Plan"
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(chooseServerVC, animated: true)
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
            self.connectButton.isUserInteractionEnabled = true
        }
    }
    
    @objc private func updateTimer() {
        seconds += 1
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        var timerText = ""
        hmsFrom(seconds: seconds) { (hours, minutes, seconds) in
            let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
            timerText =  "\(hours):\(minutes):\(seconds)"
        }
        
        return timerText
    }
    
    func showWebView(url: String) {
        let vc = SafariVC()
        vc.modalPresentationStyle = .pageSheet
        vc.url = url
        self.present(vc, animated: true, completion: nil)
    }

    private func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
            completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    private func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
}

extension MainScreenVC: ChangeServerDelegate {
    func changeServer(countryIndex: Int) {
        let flagImage = Constants.flags[countryIndex]
        let countryName = Constants.countryNames[countryIndex]
        serverFlagImage.image = UIImage(named: flagImage)
        serverCountryLabel.text = countryName
    }
}

