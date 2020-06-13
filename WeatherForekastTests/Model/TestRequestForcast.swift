//
//  TestRequestForcast.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class TestRequestForcast: XCTestCase {
    
    var request: RequestForecast!
    
    override func setUp() {
        request = RequestForecast()
    }
    
    func testInitialize() {
        XCTAssert(request.keyword == nil)
        XCTAssertEqual(request.count, PreferencesService.shared.numOfDays)
        XCTAssertEqual(request.lang, PreferencesService.shared.language)
        XCTAssertEqual(request.units, PreferencesService.shared.tempUnit)
    }
}
