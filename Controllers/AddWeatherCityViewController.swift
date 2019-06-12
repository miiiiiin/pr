//
//  AddWeatherCityViewController.swift
//  Weather
//
//  Created by 민송경 on 10/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)//pass the view model
}

class AddWeatherCityViewController: UIViewController {
    
    var delegate: AddWeatherDelegate? //making it optional -> there is a possibility that there's no one listening or subscribe
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBAction func saveCityBtnPressed(_ sender: UIButton) {
        if let city = cityNameTextField.text {
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=22d5c449d3102ec64710bb001a2eb987&units=imperial")!
            
            //provide a generic type when the data is returned from server
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                //try? -> if decoding fail, it's going to return null instead of crash
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
            
            WebService().load(resource: weatherResource) { [weak self] result in
                
                if let weatherVM = result {
                    //have to use weak self because there's a possibility of retained cycles
                    //if we're able to unwrap then we can get delegate
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM) //pass the view model to whoever subscribed to that delegate 
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
