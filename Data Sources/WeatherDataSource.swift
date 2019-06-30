//
//  WeatherDataSource.swift
//  Weather
//
//  Created by 민송경 on 24/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

//data source is responsible for populating the data or giving the data for a uiviewcontroller or uiview
class WeatherDataSource: NSObject, UITableViewDataSource {
    
    //data source will be responsible for providing data to table view controller or any other controller
    
    //pass in the cell identifer & completely remove it from initializer
    let cellIdentifer: String = "WeatherCell"
    private var weatherListVM: WeatherListViewModel
    
    init(_ weatherListVM: WeatherListViewModel) {
        
        self.weatherListVM = weatherListVM
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListVM.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifer, for: indexPath) as? WeatherCell else {
            fatalError("\(self.cellIdentifer) weathercell not found")
        }
        
        let weatherVM = self.weatherListVM.modelAt(indexPath.row)
        
        cell.cityNameLabel.text = weatherVM.name.value
        cell.tempLable.text = weatherVM.currentTemp.temp.value.formatAsDegree
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
