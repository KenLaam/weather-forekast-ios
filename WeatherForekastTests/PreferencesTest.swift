//
//  PreferencesTest.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class PrefrencesTest: XCTestCase {
    override class func setUp() {
        PreferencesService.shared.clear()
    }
    
    override func tearDown() {
        PreferencesService.shared.clear()
    }
    
    func testDefaultConfig() {
        XCTAssertEqual(PreferencesService.shared.language, AppConfiguration.DEFAULT_LANGUAGE)
        XCTAssertEqual(PreferencesService.shared.numOfDays, AppConfiguration.FORECAST_DAYS_DEFAULT)
        XCTAssertEqual(PreferencesService.shared.tempUnit, AppConfiguration.DEFAULT_TEMP_UNIT)
    }
    
    func testSaveConfig() {
        PreferencesService.shared.language = .vietnamese
        PreferencesService.shared.numOfDays = 8
        PreferencesService.shared.tempUnit = .fahrenheit
        XCTAssertEqual(PreferencesService.shared.language, Language.vietnamese)
        XCTAssertEqual(PreferencesService.shared.numOfDays, 8)
        XCTAssertEqual(PreferencesService.shared.tempUnit, TemperatureUnit.fahrenheit)
    }
}
