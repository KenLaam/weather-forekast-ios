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
    
    func testUtilsGetVC() throws {
        let homeVC = UIUtils.getViewController(in: .main)
        XCTAssert(homeVC is HomeViewController)
        let settingVC = UIUtils.getViewController(with: SettingsViewController.className, in: .main)
        XCTAssert(settingVC is SettingsViewController)
    }
    
    func testCreateHomeVC() throws {
        let navHome = Screen.home.createViewController()
        XCTAssert(navHome is UINavigationController)
        XCTAssert((navHome as! UINavigationController).viewControllers[0] is HomeViewController)
    }
    
    func testCreateSettingVC() throws {
        let handler: HandlerUpdateSettings = { request in
        }
        let settingVC = Screen.settings(handler).createViewController()
        XCTAssert(settingVC is SettingsViewController)
    }
    
    func testFlow() throws {
        Router.shared.toHome()
        XCTAssert(Router.shared.coordinator.currentViewController is HomeViewController)
        
        let handler: HandlerUpdateSettings = { request in
        }
        Router.shared.toSettings(handler: handler)
        XCTAssert(Router.shared.coordinator.currentViewController is SettingsViewController)
    }
    
    func testFlowBackToHome() throws {
        Router.shared.toHome()
        
        Router.shared.pop()
        XCTAssert(Router.shared.coordinator.currentViewController is HomeViewController)
        
        Router.shared.popToHome()
        XCTAssert(Router.shared.coordinator.currentViewController is HomeViewController)
    }
}
