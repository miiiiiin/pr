//
//  WeatherListTableViewController.swift
//  Weather
//
//  Created by 민송경 on 10/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate  {
    
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection :Unit!
    
    func addWeatherDidSave(vm: WeatherViewModel) { // where you'll send the info using the weather view model
        
        self.weatherListViewModel.addWeatherViewModel(vm)
        //add view model to we ther view models array
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCity" {
            prepareAddWeather(segue: segue)
        } else if segue.identifier == "SettingsTableView" {
            prepareSettings(segue: segue)
        } else if segue.identifier == "WeatherDetailVC" {
            prepareWeatherDetails(segue: segue)
        }
    }
    
    private func prepareAddWeather(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("nav not found") }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("addWeatherCity not found")
        }
        
        addWeatherCityVC.delegate = self
    }
    
    private func prepareSettings(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("nav not found") }
        
        guard let settingsTableVC = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("setting table not found")
        }
        
        settingsTableVC.delegate = self
    }
    
    private func prepareWeatherDetails(segue: UIStoryboardSegue) {
        // WHEN CELL CLICKDED
        guard let weatherDetailVC = segue.destination as? WeatherDeatilsViewController, let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        // ViewModel -> view binding
        weatherDetailVC.weatherViewModel = weatherVM
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let userdefaults = UserDefaults.standard
        if let value = userdefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)!
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rows: \(section )")
        return self.weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.configure(weatherVM)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension WeatherListTableViewController: settingsDelegate {
    
    func settingsDone(vm: SettingsViewModel) {
        print("settings done : \(vm)")
        
        print("last unit : \(self.lastUnitSelection.rawValue)")
        
        if self.lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
            self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
            self.tableView.reloadData()
            self.lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)
        }
    }
}
