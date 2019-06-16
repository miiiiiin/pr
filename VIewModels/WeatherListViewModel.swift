//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 민송경 on 10/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation

//controlling the whole main screen
struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
        print("models : \(self.weatherViewModels)")
    }
    
    //add number of rows on tableview
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return self.weatherViewModels[index]
    }
    
    mutating private func toCelsius() {
        
        //iterate through weather view list model
        weatherViewModels = weatherViewModels.map { vm in
            
            var weatherModel = vm
            weatherModel.currentTemp.temp = (weatherModel.currentTemp.temp - 32) * 5/9
            
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            
            var weatherModel = vm
            weatherModel.currentTemp.temp = (weatherModel.currentTemp.temp * 9/5) + 32
            
            return weatherModel
        }
    }
    
    mutating func updateUnit(to unit: Unit) {
        switch unit {
            case .celsius:
                toCelsius()
            case .fahrenheit:
                toFahrenheit()
        }
    }
}

struct WeatherViewModel: Decodable {
    let name: String
    var currentTemp: TempViewModel //when json is being decoding it's going to look at this property "main" and match with json, and try to decode all of the fields into our tempVIewModel
    
    private enum CodingKeys: String, CodingKey { //mapping with json api properties
        case name
        case currentTemp = "main"
    }
}

struct TempViewModel: Decodable {
    var temp: Double
    let tempeMin: Double
    let tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempeMin = "temp_min"
        case tempMax = "temp_max"
    }
}
