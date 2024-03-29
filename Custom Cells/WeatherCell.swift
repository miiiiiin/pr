//
//  WeatherCell.swift
//  Weather
//
//  Created by 민송경 on 10/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLable: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.cityNameLabel?.text = vm.name.value
        self.tempLable?.text = "\(vm.currentTemp.temp.value.formatAsDegree)"
        
    }
}


