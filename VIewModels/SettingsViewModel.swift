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
    
//    private var _selectedUnit: Unit = Unit.fahrenheit //default value for selected unit
    
    //selectedUnit property
    //serving as the selected unit from the unit whenever the user chagnes the selection from celsius to fahrenheit to the selected unit will get updated
    var selectedUnit: Unit {
        //get, set -> going to get the value from userdefaults
        get  {
            let userdefaults = UserDefaults.standard //userdeafult is a singleton. same object being retruned overhead
            var unitValue = ""
            if let value = userdefaults.value(forKey: "unit") as? String {
                unitValue = value
            }
            
            return Unit(rawValue: unitValue)!
            
        // set the value to userdefaults
        } set {
            let userdefaults = UserDefaults.standard
            userdefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}
