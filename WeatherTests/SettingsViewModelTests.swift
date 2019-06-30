//
//  SettingsViewModelTests.swift
//  WeatherTests
//
//  Created by 민송경 on 01/07/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsViewModelTests: XCTestCase {
    
    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.settingsVM = SettingsViewModel()
    }
    
    func test_should_return_correct_display_name_for_fahrenheit() {
        
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Fahrenheit")
    }
    
    func test_should_make_sure_that_default_select_unit_is_fahrenheit() {
        
        XCTAssertEqual(self.settingsVM.selectedUnit, .fahrenheit)
    }

    func test_should_be_able_to_save_user_unit_selection() {
        
        self.settingsVM.selectedUnit = .celsius
        
        //when we assign the selected unit a property. different temperature unit celsius. it is going to save it
        
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
}
