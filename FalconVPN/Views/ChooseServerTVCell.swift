//
//  ChooseServerTVCell.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class ChooseServerTVCell: UITableViewCell {

    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var radioImage: UIImageView!
    
    var flag: String? {
        didSet {
            if let flag = self.flag {
                countryFlagImage.image = UIImage(named: flag)
            }
        }
    }
    
    var countryName: String? {
        didSet {
            if let name = self.countryName {
                countryNameLabel.text = name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupWith(name: String, flag: String) {
        self.countryName = name
        self.flag = flag
    }
}
