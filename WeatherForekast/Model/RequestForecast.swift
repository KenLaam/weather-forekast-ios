//
//  RequestForecast.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class RequestForecast: Encodable, Equatable {
    static func == (lhs: RequestForecast, rhs: RequestForecast) -> Bool {
        return lhs.count == rhs.count && lhs.units == rhs.units && lhs.lang == rhs.lang
    }
    
    var keyword: String?
    var count: Int
    var units: TemperatureUnit
    var lang: Language
    
    init() {
        count = PreferencesService.shared.numOfDays
        units = PreferencesService.shared.tempUnit
        lang = PreferencesService.shared.language
    }
    
    enum CodingKeys: String, CodingKey {
        case keyword = "q"
        case count = "cnt"
        case units, lang
    }
}

enum TemperatureUnit: String, Encodable {
    case kelvin = "default"
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var name: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .kelvin:
            return "Kelvin"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
    
    var symbol: String {
        switch self {
        case .celsius:
            return "C"
        case .kelvin:
            return "K"
        case .fahrenheit:
            return "F"
        }
    }
}

enum Language: String, Encodable {
    case english = "en"
    case vietnamese = "vi"
    
    var name: String {
        switch self {
        case .english:
            return "English"
        case .vietnamese:
            return "Tiếng Việt"
        }
    }
}
