//
//  ChangePlanVC.swift
//  FalconVPN
//
//  Created by Mairambek on 2/26/20.
//  Copyright © 2020 Mairambek Abdrasulov. All rights reserved.
//

import UIKit

class ChangePlanVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    var selectedPlan: Int?
    
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
    
    @IBAction func changePlanButton(_ sender: UIButton) {
        guard selectedPlan != nil else { return }
        UserDefaults.standard.set(selectedPlan, forKey: Constants.currentPlanKey)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ChangePlanVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.planNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePlanTVCell", for: indexPath) as! ChangePlanTVCell
        cell.setupWith(planIndex: indexPath.row, selectedPlan: selectedPlan)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlan = indexPath.row
        tableView.reloadData()
    }
}
