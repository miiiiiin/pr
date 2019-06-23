//
//  WeatherDeatilsViewController.swift
//  Weather
//
//  Created by 민송경 on 22/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

class WeatherDeatilsViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    var weatherViewModel: WeatherViewModel?
 
    override func viewDidLoad() {
         super.viewDidLoad()
        
        // ViewModel -> view binding
//        if let weatherVM = self.weatherViewModel {
//            self.cityName.text = weatherVM.name.value
//            self.currentTemp.text = weatherVM.currentTemp.temp.value.formatAsDegree
//            self.maxTemp.text = weatherVM.currentTemp.tempMax.value.formatAsDegree
//            self.minTemp.text = weatherVM.currentTemp.tempeMin.value.formatAsDegree
//        }
        
       //use binding function
        setupViewModelBinding()
        
    }
    
    private func setupViewModelBinding() {
        if let weatherVM = self.weatherViewModel {
            weatherVM.name.bind { self.cityName.text = $0 }
            weatherVM.currentTemp.temp.bind { self.currentTemp.text = $0.formatAsDegree }
            weatherVM.currentTemp.tempMax.bind { self.maxTemp.text = $0.formatAsDegree }
             weatherVM.currentTemp.tempeMin.bind { self.minTemp.text = $0.formatAsDegree }
        }
        
        //change the value after few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.weatherViewModel?.name.value = "boston"
        }
        
        //anytime something changes in the view model that is reflected in the view
    }
}

