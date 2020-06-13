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
    
    override func setUp() {
        PreferencesService.shared.language = .vietnamese
    }
    
    func testEmpty() throws {
        let error = ErrorResponse(.empty)
        XCTAssertEqual(error.message, "Hãy tìm thành phố của bạn để biết dự báo thời tiết!")
        XCTAssertEqual(error.iconName, "ic_cloud_empty")
    }
    
    func testOffline() throws {
        let error = ErrorResponse(.offline)
        XCTAssertEqual(error.message, "Đã mất kết nối.\nVui lòng kiểm tra lại kết nối!")
        XCTAssertEqual(error.iconName, "ic_cloud_link")
    }
    
    func testTimeout() throws {
        let error = ErrorResponse(.timeout)
        XCTAssertEqual(error.message, "Hết thời gian chờ.\nVui lòng thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_retry")
    }
    
    func testNotFound() throws {
        let error = ErrorResponse(.notFound)
        XCTAssertEqual(error.message, "Không tìm thấy thành phố!\nVui lòng thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_error")
    }
    
    func testMinChars() throws {
        let error = ErrorResponse(.minChars)
        XCTAssertEqual(error.message, "Hãy nhập ít nhất 3 ký tự!")
        XCTAssertEqual(error.iconName, "ic_cloud_warning")
    }
    
    func testOthers() throws {
        let error = ErrorResponse(.others)
        XCTAssertEqual(error.message, "Có lỗi xảy ra.\nHãy thử lại!")
        XCTAssertEqual(error.iconName, "ic_cloud_warning")
    }
}

