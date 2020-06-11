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
    let lstForecast: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case city
        case lstForecast = "list"
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
    
    enum CodingKeys: String, CodingKey {
        case pressure, humidity
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
