//
//  TestHomeViewModel.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
import RxSwift
@testable import WeatherForekast

class TestHomeViewModel: XCTestCase {
    var viewModel: HomeViewModel!
    var recorderForcast: SubjectRecorder<Forecast>!
    var recorderError: SubjectRecorder<ErrorResponse?>!
    
    override func setUp() {
        viewModel = HomeViewModel()
        recorderForcast = SubjectRecorder<Forecast>()
        recorderForcast.on(arraySubject: viewModel.forecast)
        recorderError = SubjectRecorder<ErrorResponse?>()
        recorderError.on(valueSubject: viewModel.error)
    }
    
    func testInitialize() {
        XCTAssertEqual(viewModel.request.count, PreferencesService.shared.numOfDays)
        XCTAssertEqual(viewModel.request.lang, PreferencesService.shared.language)
        XCTAssertEqual(viewModel.request.units, PreferencesService.shared.tempUnit)
    }
    
    func testSearchWith2Chars() {
        viewModel.fetchForecast("PU")
        XCTAssert(recorderError.items.last??.type == ErrorResponse.ErrorType.minChars)
        XCTAssert(recorderForcast.items.isEmpty)
    }
    
    func testSearchValidResult() {
        let expectDone = self.expectation(description: "Fetch successfully")
        viewModel.fetchForecast("Saigon")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            expectDone.fulfill()
        })
        wait(for: [expectDone], timeout: 2)
        XCTAssert(recorderError.items.last! == nil)
        XCTAssertFalse(recorderForcast.items.isEmpty)
    }
    
    func testSearchNotFound() {
        let expectDone = self.expectation(description: "Fetch Done")
        viewModel.fetchForecast("Saigonese")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            expectDone.fulfill()
        })
        wait(for: [expectDone], timeout: 2)
        XCTAssert(recorderError.items.last??.type == ErrorResponse.ErrorType.notFound)
        XCTAssert(recorderForcast.items.isEmpty)
    }
    
    func testSearchWith10Days() {
        let expectDone = self.expectation(description: "Fetch Done")
        viewModel.request.count = 10
        viewModel.fetchForecast("Saigon")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            expectDone.fulfill()
        })
        wait(for: [expectDone], timeout: 2)
        XCTAssert(recorderForcast.items.count == 10)
    }
    
    func testNavigation() {
        viewModel.openSettings()
        XCTAssert(Router.shared.coordinator.currentViewController is SettingsViewController)
    }
    
    func testUpdateCount() {
        viewModel.openSettings()
        guard let settingVC = Router.shared.coordinator.currentViewController as? SettingsViewController else {
            return
        }
        settingVC.viewModel.updateNumOfDays(3)
        settingVC.viewModel.updateLanguage(.vietnamese)
        settingVC.viewModel.finishSettings()
        
        let expectDone = self.expectation(description: "Fetch Done")
        XCTAssertEqual(viewModel.request.count, 3)
        XCTAssertEqual(viewModel.request.lang, Language.vietnamese)
        viewModel.fetchForecast("Saigon")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            expectDone.fulfill()
        })
        wait(for: [expectDone], timeout: 2)
        XCTAssert(recorderForcast.items.count == 3)
    }
}

