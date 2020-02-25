//
//  ChoosePlanTVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/24/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class ChoosePlanTVC: UITableViewController {

    @IBOutlet weak var annualPlanView: UIView!
    @IBOutlet weak var monthlyPlanView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      setupView()
    }

    

    func setupView() {
        let annualTap = UITapGestureRecognizer(target: self, action: #selector(self.annualPlanTapped(_:)))
        let monthlyTap = UITapGestureRecognizer(target: self, action: #selector(self.monthlyPlanTapped(_:)))
        annualPlanView.addGestureRecognizer(annualTap)
        monthlyPlanView.addGestureRecognizer(monthlyTap)

    }
    
    @objc func annualPlanTapped(_ sender: UITapGestureRecognizer? = nil) {
        annualPlanView.borderColor = #colorLiteral(red: 0.003921568627, green: 0.6901960784, blue: 0.4588235294, alpha: 1)
        monthlyPlanView.borderColor = #colorLiteral(red: 0.1960784314, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
    }
    
    @objc func monthlyPlanTapped(_ sender: UITapGestureRecognizer? = nil) {
        monthlyPlanView.borderColor = #colorLiteral(red: 0.003921568627, green: 0.6901960784, blue: 0.4588235294, alpha: 1)
        annualPlanView.borderColor = #colorLiteral(red: 0.1960784314, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
    }

    
    @IBAction func dismissButton(_ sender: UIButton) {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
    
        
    }

}
    
    
