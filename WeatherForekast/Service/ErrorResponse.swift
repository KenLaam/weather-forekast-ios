//
//  ErrorResponse.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class ErrorResponse: Error {
    enum ErrorType {
        case offline
        case empty
        case timeout
        case notFound
        case minChars
        case others
    }
    
    var type: ErrorType!
    var message: String {
        switch type {
        case .offline:
            return "ERROR_OFFLINE".localized()
        case .timeout:
            return "ERROR_TIMEOUT".localized()
        case .empty:
            return "ERROR_EMPTY".localized()
        case .notFound:
            return "ERROR_NOT_FOUND".localized()
        case .minChars:
            return "ERROR_MIN_CHARACTER".localized()
        default:
            return "ERROR_OTHER".localized()
        }
    }
    
    var iconName: String {
        switch type {
        case .offline:
            return "ic_cloud_link"
        case .timeout:
            return "ic_cloud_retry"
        case .empty:
            return "ic_cloud_empty"
        case .notFound:
            return "ic_cloud_error"
        case .minChars:
            return "ic_cloud_warning"
        default:
            return "ic_cloud_warning"
        }
    }
    
    init(_ type: ErrorType) {
        self.type = type
    }
}
