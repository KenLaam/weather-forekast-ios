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
    
    init(_ forecast: Forecast) {
        self.forecast = forecast
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
