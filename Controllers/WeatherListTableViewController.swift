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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
