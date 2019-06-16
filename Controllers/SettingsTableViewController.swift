//
//  SettingsTableViewController.swift
//  Weather
//
//  Created by Min on 13/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

protocol settingsDelegate {
    func settingsDone(vm: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingViewModel = SettingsViewModel()
    
    var delegate: settingsDelegate?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //allows you to  change the ui of tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //uncheck all the cells
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            self.settingViewModel.selectedUnit = unit
            print(self.settingViewModel.selectedUnit)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingItem = self.settingViewModel.units[indexPath.row]

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        
        cell.textLabel?.text = settingItem.displayName
        
        print("settingsitem ? \(self.settingViewModel.selectedUnit)")
        
        if settingItem == self.settingViewModel.selectedUnit {
            
            cell.accessoryType = .checkmark
        } 
        
        return cell
    }
    
    @IBAction func done(_ sender: Any) {
        
        if let delegate = self.delegate {
            delegate.settingsDone(vm: self.settingViewModel)
        }
        dismiss(animated: true, completion: nil)
    }
}
