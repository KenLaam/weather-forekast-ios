//
//  TestErrorResponse.swift
//  WeatherForekastTests
//
//  Created by Ken Lâm on 6/13/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import XCTest
@testable import WeatherForekast

class TestErrorResponse: XCTestCase {
    
    override class func setUp() {
        PreferencesService.shared.language = .vietnamese
    }
    
    func testEmpty() {
        let error = ErrorResponse(.empty)
        XCTAssertEqual(error.message, "Hãy tìm thành phố của bạn để biết dự báo thời tiết!")
        XCTAssertEqual(error.iconName, "ic_cloud_empty")
    }
    
    func testOffline() {
        let error = ErrorResponse(.offline)
        XCTAssertEqual(error.message, "Đã mất kết nối.\nVui lòng kiểm tra lại kết nối!")
        XCTAssertEqual(error.iconName, "ic_cloud_link")
    }
    
    func testTimeout() {
        let error = ErrorResponse(.timeout)
        XCTAssertEqual(error.message, "Hết thời gian chờ.\nVui lòng thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_retry")
    }
    
    func testNotFound() {
        let error = ErrorResponse(.notFound)
        XCTAssertEqual(error.message, "Không tìm thấy thành phố!\nVui lòng thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_error")
    }
    
    func testMinChars() {
        let error = ErrorResponse(.minChars)
        XCTAssertEqual(error.message, "Hãy nhập ít nhất 3 ký tự!")
        XCTAssertEqual(error.iconName, "ic_cloud_warning")
    }
    
    func testOthers() {
        let error = ErrorResponse(.others)
        XCTAssertEqual(error.message, "Có lỗi xảy ra.\nHãy thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_warning")
    }
}

