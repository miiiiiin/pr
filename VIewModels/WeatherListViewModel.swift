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
            
            let weatherModel = vm
            weatherModel.currentTemp.temp.value = (weatherModel.currentTemp.temp.value - 32) * 5/9
            
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            
            let weatherModel = vm
            weatherModel.currentTemp.temp.value = (weatherModel.currentTemp.temp.value * 9/5) + 32
            
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


//Type Eraser
//<T> -> Generic type (it can work on strings and different types)
//make sure that the type is allowed to decodable
class Dynamic<T>: Decodable where T: Decodable {
    
    //shorthand for our type
    typealias Listener = ( T) -> () //closure, going to return the same type that value contains
    //closure not able to conform to decodable
    
    var listener: Listener?
    
    var value: T {
        didSet {
            //listener : it can pass in that particular type
            listener?(value)
        }
    }
    
    //have to allow the ui to bind to this particular value
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value) //fire the listener
        
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    //for the closure (type 'Dynamic' does not conform to protocol 'Decodable')
    private enum CodingKeys: CodingKey {
        case value
    }
}


struct WeatherViewModel: Decodable {
    let name: Dynamic<String>
    var currentTemp: TempViewModel //when json is being decoding it's going to look at this property "main" and match with json, and try to decode all of the fields into our tempVIewModel
    
    //decodable initializer
    init(from decoder: Decoder) throws {
        
        //accept the container (get the container by type keyedby, which will be represented by codingkeys.self)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemp = try container.decode(TempViewModel.self, forKey: .currentTemp)
    }
    
    private enum CodingKeys: String, CodingKey { //mapping with json api properties
        case name
        case currentTemp = "main"
    }
}

struct TempViewModel: Decodable {
    var temp: Dynamic<Double>
    let tempeMin: Dynamic<Double>
    let tempMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = Dynamic(try container.decode(Double.self, forKey: .temp))
        tempeMin = Dynamic(try container.decode(Double.self, forKey: .tempeMin))
        tempMax = Dynamic(try container.decode(Double.self, forKey: .tempMax))
    }
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempeMin = "temp_min"
        case tempMax = "temp_max"
    }
}
