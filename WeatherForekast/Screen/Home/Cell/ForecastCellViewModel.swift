//
//  ForecastCellViewModel.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/12/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastCellViewModel: BaseViewModel, ViewModelType {
    struct Input {
    }
    
    struct Output {
    }
    
    var forecast: Forecast!
    var date = BehaviorRelay<String>(value: "")
    var temp = BehaviorRelay<String>(value: "")
    var pressure = BehaviorRelay<String>(value: "")
    var humidity = BehaviorRelay<String>(value: "")
    var description = BehaviorRelay<String>(value: "")
    
    init(_ forecast: Forecast) {
        self.forecast = forecast
        date.accept("Date: \(forecast.date ?? 0)")
        temp.accept("Average temperature: \(forecast.temperature.day ?? 0.0)")
        pressure.accept("Pressure: \(forecast.pressure ?? 0)")
        humidity.accept("Humidity: \(forecast.humidity ?? 0)")
        description.accept("Description: \(forecast.weather[0].description ?? "")")
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
