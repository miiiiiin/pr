//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Min on 16/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    
    //custom properties(getter)
    var displayName: String {
        get {
            switch (self) {// where self is unit structure
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
                
            }
        }
    }
}

struct SettingsViewModel {
    
//    let units = [Unit.celsius, Unit.fahrenheit] //to display on table view (it has to be array)
    let units = Unit.allCases // give all the different cases
    
}
