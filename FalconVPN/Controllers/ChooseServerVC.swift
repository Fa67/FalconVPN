//
//  ChooseServerVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class ChooseServerVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    var delegate: ChangeServerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ChooseServerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.countryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = Constants.countryNames[indexPath.row]
        let flag = Constants.flags[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseServerTVCell", for: indexPath) as! ChooseServerTVCell
        cell.setupWith(name: name, flag: flag)
        if selectedIndex == indexPath.row {
            cell.radioImage.image = #imageLiteral(resourceName: "ic_RadioOn")
        } else {
            cell.radioImage.image = #imageLiteral(resourceName: "ic_radioOff")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        UserDefaults.standard.set(indexPath.row, forKey: Constants.currentServerKey)
        delegate?.changeServer(countryIndex: indexPath.row)
        tableView.reloadData()
    }
    
    
}
