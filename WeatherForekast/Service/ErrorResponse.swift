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
        case others
    }
    
    var type: ErrorType!
    var message: String {
        switch type {
        case .offline:
            return "Your connection appears to be offline.\nPlease check your connection!"
        case .timeout:
            return "Time out.\nPlease try again!"
        case .empty:
            return "Nothing here.\nTry search your city for weather forecast!"
        case .notFound:
            return "City not found!\nTry again!"
        default:
            return "Something went wrong.\nPlease try again!"
        }
    }
    
    init(_ type: ErrorType) {
        self.type = type
    }
}
