//
//  RouterTests.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class RouterTests: XCTestCase {
    
    func testCreateHomeVC() {
        let navHome = Screen.home.createViewController()
        XCTAssert(navHome is UINavigationController)
        XCTAssert((navHome as! UINavigationController).viewControllers[0] is HomeViewController)
    }
    
    func testCreateSettingVC() {
        let handler: HandlerUpdateSettings = { request in
        }
        let settingVC = Screen.settings(handler).createViewController()
        XCTAssert(settingVC is SettingsViewController)
    }
}
