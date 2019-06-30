//
//  WeatherListViewModelTests.swift
//  WeatherTests
//
//  Created by 민송경 on 01/07/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherListViewModelTests: XCTestCase {
    
    private var weatherListVM: WeatherListViewModel!

    override func setUp() {
        super.setUp()
        
        self.weatherListVM = WeatherListViewModel()
//        self.weatherListVM.addWeatherViewModel(WeatherViewModel(name: "Houston", currentTemperature: TempViewModel(temp: 32, tempMin: 0, tempMax: 0)))
//
//         self.weatherListVM.addWeatherViewModel(WeatherViewModel(name: "Austin", currentTemperature: TempViewModel(temp: 72, tempMin: 0, tempMax: 0)))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_should_be_able_to_convert_to_celsius_successfully() {
        
        let celsiusTemp = [0, 22.2222]
        
        self.weatherListVM.updateUnit(to: .celsius)
        
        for (index, vm) in self.weatherListVM.weatherViewModels.enumerated() {
            
            XCTAssertEqual(round(vm.currentTemp.temp.value), round(celsiusTemp[index]))
        }
    }

}
