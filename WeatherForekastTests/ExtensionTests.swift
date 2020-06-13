//
//  ExtensionTests.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClassName() throws {
        XCTAssertEqual(HomeViewController.className, "HomeViewController")
        XCTAssertEqual(ForecastTableViewCell().className, "ForecastTableViewCell")
    }
    
    func testDateTime() {
        let today = Date()
        let format = "dd/MM.yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let todayStr = formatter.string(from: today)
        XCTAssertEqual(today.toString(format), todayStr)
    }
    
    func testLocalizationEnglish() {
        PreferencesService.shared.language = .english
        XCTAssertEqual("SETTINGS_TITLE".localized(), "Settings")
        XCTAssertEqual("CELL_DESCRIPTION".localizedFormat("sunny day"), "Description: sunny day")
        XCTAssertEqual("CELL_HUMIDITY".localizedFormat(arguments: 12, using: nil, in: nil), "Humidity: 12%")
    }
    
    func testLocalizationVietnamese() {
        PreferencesService.shared.language = .vietnamese
        XCTAssertEqual("SETTINGS_TITLE".localized(), "Cài đặt")
        XCTAssertEqual("CELL_DESCRIPTION".localizedFormat("sunny day"), "Mô tả: sunny day")
    }
}
