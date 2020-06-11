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
    var unit: TemperatureUnit = .kelvin
    var lang: String?
}

enum TemperatureUnit: String, Encodable {
    case kelvin = "Kelvin"
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
}
