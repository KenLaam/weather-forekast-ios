//
//  TestSettingViewModel.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class TestSettingViewModel: XCTestCase {
    var viewModel: SettingsViewModel!
    
    override func setUp() {
        let handler: HandlerUpdateSettings = { request in
            
        }
        viewModel = SettingsViewModel(handler)
    }
    
    func testInitialize() {
        XCTAssertEqual(viewModel.request.count, PreferencesService.shared.numOfDays)
        XCTAssertEqual(viewModel.request.lang, PreferencesService.shared.language)
        XCTAssertEqual(viewModel.request.units, PreferencesService.shared.tempUnit)
    }
    
    func testUpdateData() {
        viewModel.updateLanguage(.vietnamese)
        viewModel.updateTempUnit(.kelvin)
        viewModel.updateNumOfDays(2)
        
        XCTAssertEqual(viewModel.request.count, 2)
        XCTAssertEqual(viewModel.request.lang, Language.vietnamese)
        XCTAssertEqual(viewModel.request.units, TemperatureUnit.kelvin)
        
        viewModel.finishSettings()
        XCTAssertEqual(PreferencesService.shared.numOfDays, 2)
        XCTAssertEqual(PreferencesService.shared.language, Language.vietnamese)
        XCTAssertEqual(PreferencesService.shared.tempUnit, TemperatureUnit.kelvin)
    }
}
