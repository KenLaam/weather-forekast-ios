//
//  ResponseForecast.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

class ResponseForecast: Decodable {
    let city: City?
    let code: String
    let lstForecast: [Forecast]?
    
    enum CodingKeys: String, CodingKey {
        case city
        case code = "cod"
        case lstForecast = "list"
    }
    
    var isNotFound: Bool {
        return code == "404"
    }
}

class City: Decodable {
    let id: Int?
    let name: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, country
    }
}

class Forecast: Decodable {
    let date: Int?
    let pressure: Int?
    let humidity: Int?
    let temperature: Temperature
    let weather: [Weather]
    
    var dateTime: String {
        guard let timestamp = date else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return date.toString()
    }
    
    var tempAverage: String {
        guard let day = temperature.day else { return "" }
        return String(format: "%.0f\u{00B0}%@", day, PreferencesService.shared.tempUnit.symbol)
    }
    
    enum CodingKeys: String, CodingKey {
        case pressure, humidity, weather
        case date = "dt"
        case temperature = "temp"
    }
}

class Temperature: Decodable {
    let day: Double?
    let min: Double?
    let max: Double?
    
    enum CodingKeys: String, CodingKey {
        case min, max, day
    }
}

class Weather: Decodable {
    let main: String?
    let description: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case main, description, icon
    }
    
    var iconURL: String? {
        guard let icon = icon else { return nil}
        return "http://openweathermap.org/img/wn/\(icon).png"
    }
}
