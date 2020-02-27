//
//  MenuController.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    var tableView: UITableView!
    var delegate: HomeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: "MenuOptionCell")
        tableView.register(MenuHeaderTVCell.nib, forCellReuseIdentifier: MenuHeaderTVCell.identifier)
        tableView.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.1333333333, blue: 0.1529411765, alpha: 1)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuHeaderTVCell.identifier, for: indexPath) as! MenuHeaderTVCell

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell", for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row - 1)
        let imageName = Constants.menuImages[indexPath.row - 1]
        cell.descriptionLabel.text =  menuOption?.description
        cell.iconImageView.image = UIImage(named: imageName)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 0 else { return }
        let menuOption = MenuOption(rawValue: indexPath.row-1)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260
        }
        
        return 50
    }
}
