//
//  RequestForecast.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class RequestForecast: Encodable {
    var keyword: String?
    var count: Int = AppConfiguration.FORECAST_DAYS_MIN
    var units: TemperatureUnit?
    var lang: String?
    
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
