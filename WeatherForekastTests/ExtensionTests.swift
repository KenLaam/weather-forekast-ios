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
    }
}
