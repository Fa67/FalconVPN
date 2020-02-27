//
//  ChangePlanTVCell.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class ChangePlanTVCell: UITableViewCell {

    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isCurrentLabel: UILabel!
    @IBOutlet weak var radioImage: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    
    func setupWith(planIndex: Int, selectedPlan: Int?) {
        let currentPlan = UserDefaults.standard.integer(forKey: Constants.currentPlanKey)
        
        if currentPlan == planIndex {
            self.isUserInteractionEnabled = false
            self.isCurrentLabel.isHidden = false
            self.radioImage.isHidden = true
        } else {
            self.isUserInteractionEnabled = true
            self.isCurrentLabel.isHidden = true
            self.radioImage.isHidden = false
        }
        
        if let index = selectedPlan, index == planIndex {
            self.radioImage.image = #imageLiteral(resourceName: "ic_RadioOn")
        } else {
            self.radioImage.image = #imageLiteral(resourceName: "ic_radioOff")
        }
        
        let planName = Constants.planNames[planIndex]
        let planPrice = Constants.planPrices[planIndex]

        planNameLabel.text = planName
        priceLabel.text = planPrice
    }

}
